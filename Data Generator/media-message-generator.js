const Fs = require('graceful-fs');
const Path = require('path');
const SparkMD5 = require('spark-md5');
const Fetch = require('node-fetch');
const Config = require('./config');

const JPGPath = Path.resolve('../Test Media/JPG');
const GIFPath = Path.resolve('../Test Media/GIF');

function getFileNames() {
  const JPGFiles = Fs.readdirSync(JPGPath).filter(s => s.includes('.jpg'));
  const GIFFiles = Fs.readdirSync(GIFPath).filter(s => s.includes('.gif'));
  return { jpg: JPGFiles, gif: GIFFiles };
}

function generateMedia() {
  return _uploadMediaItems().then(uploadedMediaItems => {

    // check if all media items are transcoded
    for (const mediaItem of uploadedMediaItems) {
      if (!mediaItem.web_folder) {
        console.log(mediaItem);
        console.error('All media items were not transcoded. Please run the script again in some time.');
        process.exit();
      }
    }

    // all items were transcoded, create URL-s for the items
    return uploadedMediaItems.map(m => `https://media-dev.pairby.com/${m.web_folder}/l.${(m.mime_type.includes('gif') ? 'gif' : 'jpg')}`);
  });
}

function _uploadMediaItems() {
  const filenames = getFileNames();

  const allUploads = [];
  for (const filename of filenames.jpg) allUploads.push(_uploadMediaItem(Path.resolve(JPGPath, filename)));
  for (const filename of filenames.gif) allUploads.push(_uploadMediaItem(Path.resolve(GIFPath, filename)));
  return Promise.all(allUploads);
}

function _uploadMediaItem(path) {
  console.log(`[media-message-generator] UPLOAD STARTED: "${path}".`);
  return new Promise(resolve => {
    Fs.stat(path, (error, stats) => {
      const size = stats.size;

      Fs.readFile(path, (error, data) => {
        const md5 = SparkMD5.hash(data);

        Fetch('https://api-dev.pairby.com/v1/media', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json', 'Authorization': `Bearer ${Config.ACCESS_TOKEN}` },
          body: JSON.stringify({ media_stubs: [{ original_size_bytes: size, original_checksum: md5, original_path: path, upload_type: 'I', upload_size_bytes: size, upload_path: path }] })
        })
        .then(response => response.json())
        .then(mediaItems => {
          const mediaItem = mediaItems[0];
          if (mediaItem.web_folder) {
            console.log(`[media-message-generator] UPLOAD FINISHED: "${path}".`);
            resolve(mediaItem);
            return;
          } else if (mediaItem.missing_chunks) {
            Fetch(`https://api-dev.pairby.com/v1/media/${mediaItem.media_id}/1`, {
              method: 'POST',
              headers: { 'Content-Type': 'application/octet-stream', 'Authorization': `Bearer ${Config.ACCESS_TOKEN}` },
              body: data
            })
            .then(response => response.json())
            .then(mediaItem => {
              console.log(`[media-message-generator] UPLOAD FINISHED: "${path}".`);
              resolve(mediaItem);
              return;
            });
          } else {
            console.error('A media item upload has failed completely.', mediaItem);
            process.exit();
          }
        });
      });
    });
  });
}

module.exports = { generateMedia };
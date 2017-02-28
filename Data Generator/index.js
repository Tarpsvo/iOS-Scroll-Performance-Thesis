const Fs = require('graceful-fs');
const Path = require('path');
const Config = require('./config');
const Random = require('./random');
const TextMessageGenerator = require('./text-message-generator');
const MediaMessageGenerator = require('./media-message-generator');

function generateMessages() {
  MediaMessageGenerator.generateMedia().then(mediaItemUrls => {

    let messages = [];
    for (let i = 0; i < Config.MESSAGE_COUNT; i++) {
      // TEXT MESSAGE
      if (Math.random() > Config.MEDIA_MESSAGE_PROBABILITY) {
        messages.push({
          id: i,
          message: TextMessageGenerator(i),
          direction: (Math.random() >= 0.5) ? 'out' : 'in'
        });
        continue;
      }

      // MEDIA MESSAGE
      else {
        const numberOfMediaItems = Random(1, Config.MAX_MEDIA_ITEMS);
        let mediaItems = [];
        for (let i = 0; i < numberOfMediaItems; i++) mediaItems.push(mediaItemUrls[Random(0, mediaItemUrls.length - 1)]);
        messages.push({
          id: i,
          direction: (Math.random() >= 0.5) ? 'out' : 'in',
          mediaItems: mediaItems
        });
        continue;
      }
    }

    saveMessages(messages);
  });
}

function saveMessages(messages) {
  Fs.writeFile(Path.resolve('MessagesJSON.json'), JSON.stringify(messages));
}

generateMessages();

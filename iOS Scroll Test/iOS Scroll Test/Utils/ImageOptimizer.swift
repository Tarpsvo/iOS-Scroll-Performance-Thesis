import UIKit
import PINRemoteImage

class ImageOptimizer {
    static func processImage(image: UIImage, size: CGFloat) -> UIImage {
        let imageRect = CGRect(x: 0, y: 0, width: size, height: size)

        UIGraphicsBeginImageContext(imageRect.size)

        let sizeMultiplier: CGFloat = (size / image.size.width)

        var drawRect = CGRect(x: 0, y: 0, width: image.size.width * sizeMultiplier, height: image.size.height * sizeMultiplier)
        UIBezierPath(roundedRect: drawRect, cornerRadius: 15.0).addClip()
        if (drawRect.maxX > imageRect.maxX) { drawRect.origin.x -= (drawRect.maxX - imageRect.maxX) / 2 }
        if (drawRect.maxY > imageRect.maxY) { drawRect.origin.y -= (drawRect.maxY - imageRect.maxY) / 2 }

        image.draw(in: drawRect)

        let processedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return processedImage!
    }

    static func handleAndSetImage(imageView: FLAnimatedImageView, urlString: String, size: CGFloat) {
        imageView.pin_clearImages()
        let url = URL(string: urlString)

        // if it's a gif, we can't process it
        if (urlString.substring(from: urlString.index(urlString.endIndex, offsetBy: -3)) == "gif") {
            imageView.pin_setImage(from: url)
        } else {
            imageView.pin_setImage(from: url, processorKey: "scaled_\(size)") { (result, unsafePointer) -> UIImage? in
                guard let image = result.image else { return nil }
                return ImageOptimizer.processImage(image: image, size: size)
            }
        }
    }
}
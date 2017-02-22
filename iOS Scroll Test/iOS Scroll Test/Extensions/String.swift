import UIKit

extension String {

    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let style = NSMutableParagraphStyle()
        style.lineBreakMode = .byWordWrapping
        
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font, NSParagraphStyleAttributeName: style], context: nil)
        return boundingBox.height
    }

}

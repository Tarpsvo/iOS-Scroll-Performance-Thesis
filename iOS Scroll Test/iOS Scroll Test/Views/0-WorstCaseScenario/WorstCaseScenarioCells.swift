import UIKit
import SnapKit
import PINRemoteImage

// -----------------
// -- TEXT CELL
// -----------------
class WorstCaseScenario_TextCell: UITableViewCell {

    private var _messageLabelWrap: UIView!
    private var _messageLabel: UILabel!

    init(message: Message) {
        super.init(style: .default, reuseIdentifier: nil)

        // set up wrapper
        self._messageLabelWrap = UIView()
        self.contentView.addSubview(self._messageLabelWrap)
        self._messageLabelWrap.snp.makeConstraints { make -> Void in
            make.top.equalTo(self.contentView).offset(5)
            make.bottom.equalTo(self.contentView).offset(-5)

            // set alignment according to message direction
            if (message.direction == "out") {
                make.left.greaterThanOrEqualTo(self.contentView).offset(Pairby.MessageUI.MARGIN_HORIZONTAL_WRAP_DYNAMIC)
                make.right.equalTo(self.contentView).offset(-Pairby.MessageUI.MARGIN_HORIZONTAL_WRAP_FIXED)
            } else {
                make.left.equalTo(self.contentView).offset(Pairby.MessageUI.MARGIN_HORIZONTAL_WRAP_FIXED)
                make.right.lessThanOrEqualTo(self.contentView).offset(-Pairby.MessageUI.MARGIN_HORIZONTAL_WRAP_DYNAMIC)
            }
        }
        self._messageLabelWrap.layer.masksToBounds = true
        self._messageLabelWrap.layer.cornerRadius = 15.0

        // set up text label
        self._messageLabel = UILabel()
        self._messageLabelWrap.addSubview(self._messageLabel)
        self._messageLabel.snp.makeConstraints { make -> Void in
            make.top.equalTo(self._messageLabelWrap).offset(Pairby.MessageUI.MARGIN_VERTICAL)
            make.right.equalTo(self._messageLabelWrap).offset(-Pairby.MessageUI.MARGIN_HORIZONTAL)
            make.bottom.equalTo(self._messageLabelWrap).offset(-Pairby.MessageUI.MARGIN_VERTICAL)
            make.left.equalTo(self._messageLabelWrap).offset(Pairby.MessageUI.MARGIN_HORIZONTAL)
        }
        self._messageLabel.font = Pairby.MessageUI.TEXT_FONT
        self._messageLabel.numberOfLines = 0
        self._messageLabel.lineBreakMode = .byWordWrapping

        // set colors according to message alignment
        if (message.direction == "out") {
            self._messageLabelWrap.backgroundColor = Pairby.Colors.TEAL
            self._messageLabel.textColor = UIColor.white
        } else {
            self._messageLabelWrap.backgroundColor = Pairby.Colors.BLUE_GRAY_50
            self._messageLabel.textColor = Pairby.Colors.BLUE_GRAY_700
        }

        // set text
        if let message = message.message { self._messageLabel.text = message }
        else { self._messageLabel.text = "Media message with ID [\(message.id)]" }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// -----------------
// -- MEDIA CELL
// -----------------
class WorstCaseScenario_MediaCell: UITableViewCell {

    private var _imageView_1: FLAnimatedImageView!
    private var _imageView_2: FLAnimatedImageView!
    private var _imageView_3: FLAnimatedImageView!

    init(message: Message) {
        super.init(style: .default, reuseIdentifier: nil)
        if let mediaItems = message.mediaItems {
            if (mediaItems.count == 1) { self.setup_oneMediaItem(message: message) }
            if (mediaItems.count == 2) { self.setup_twoMediaItems(message: message) }
            if (mediaItems.count == 3) { self.setup_threeMediaItems(message: message) }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup_oneMediaItem(message: Message) {
        // set up one imageview
        self._imageView_1 = FLAnimatedImageView()
        self.contentView.addSubview(self._imageView_1)
        self._imageView_1.snp.makeConstraints { make -> Void in
            make.top.equalTo(self.contentView).offset(Pairby.MessageUI.MARGIN_VERTICAL)
            make.bottom.equalTo(self.contentView).offset(-Pairby.MessageUI.MARGIN_VERTICAL)
            make.height.equalTo(Pairby.MessageUI.HEIGHT_MEDIA_ONE)
            make.width.equalTo(Pairby.MessageUI.HEIGHT_MEDIA_ONE)
        }
        self._imageView_1.layer.masksToBounds = true
        self._imageView_1.layer.cornerRadius = 15.0
        self._imageView_1.layer.borderWidth = 1.0
        self._imageView_1.layer.borderColor = Pairby.Colors.BLUE_GRAY_50.cgColor
        self._imageView_1.pin_setImage(from: URL(string: message.mediaItems![0]))
        
        // set alignment depending on message direction
        if message.direction == "out" {
            self._imageView_1.snp.makeConstraints { make -> Void in
                make.right.equalTo(self.contentView).offset(-Pairby.MessageUI.MARGIN_HORIZONTAL)
            }
        } else {
            self._imageView_1.snp.makeConstraints { make -> Void in
                make.left.equalTo(self.contentView).offset(Pairby.MessageUI.MARGIN_HORIZONTAL)
            }
        }
    }
    
    private func setup_twoMediaItems(message: Message) {
        // set up first imageview
        self._imageView_1 = FLAnimatedImageView()
        self.contentView.addSubview(self._imageView_1)
        self._imageView_1.snp.makeConstraints { make -> Void in
            make.top.equalTo(self.contentView).offset(Pairby.MessageUI.MARGIN_VERTICAL)
            make.bottom.equalTo(self.contentView).offset(-Pairby.MessageUI.MARGIN_VERTICAL)
            make.height.equalTo(Pairby.MessageUI.HEIGHT_MEDIA_MULTIPLE)
            make.width.equalTo(Pairby.MessageUI.HEIGHT_MEDIA_MULTIPLE)
        }
        self._imageView_1.layer.masksToBounds = true
        self._imageView_1.layer.cornerRadius = 15.0
        self._imageView_1.layer.borderWidth = 1.0
        self._imageView_1.layer.borderColor = Pairby.Colors.BLUE_GRAY_50.cgColor
        self._imageView_1.pin_setImage(from: URL(string: message.mediaItems![0]))
        
        // set up second imageview
        self._imageView_2 = FLAnimatedImageView()
        self.contentView.addSubview(self._imageView_2)
        self._imageView_2.snp.makeConstraints { make -> Void in
            make.top.equalTo(self.contentView).offset(Pairby.MessageUI.MARGIN_VERTICAL)
            make.bottom.equalTo(self.contentView).offset(-Pairby.MessageUI.MARGIN_VERTICAL)
            make.height.equalTo(Pairby.MessageUI.HEIGHT_MEDIA_MULTIPLE)
            make.width.equalTo(Pairby.MessageUI.HEIGHT_MEDIA_MULTIPLE)
            make.left.equalTo(self._imageView_1.snp.right).offset(5)
        }
        self._imageView_2.layer.masksToBounds = true
        self._imageView_2.layer.cornerRadius = 15.0
        self._imageView_2.layer.borderWidth = 1.0
        self._imageView_2.layer.borderColor = Pairby.Colors.BLUE_GRAY_50.cgColor
        self._imageView_2.pin_setImage(from: URL(string: message.mediaItems![1]))
        
        // set alignment depending on message direction
        if message.direction == "out" {
            self._imageView_2.snp.makeConstraints { make -> Void in
                make.right.equalTo(self.contentView).offset(-Pairby.MessageUI.MARGIN_HORIZONTAL)
            }
        } else {
            self._imageView_1.snp.makeConstraints { make -> Void in
                make.left.equalTo(self.contentView).offset(Pairby.MessageUI.MARGIN_HORIZONTAL)
            }
        }
    }
    
    private func setup_threeMediaItems(message: Message) {
        // set up first imageview
        self._imageView_1 = FLAnimatedImageView()
        self.contentView.addSubview(self._imageView_1)
        self._imageView_1.snp.makeConstraints { make -> Void in
            make.top.equalTo(self.contentView).offset(Pairby.MessageUI.MARGIN_VERTICAL)
            make.bottom.equalTo(self.contentView).offset(-Pairby.MessageUI.MARGIN_VERTICAL)
            make.height.equalTo(Pairby.MessageUI.HEIGHT_MEDIA_MULTIPLE)
            make.width.equalTo(Pairby.MessageUI.HEIGHT_MEDIA_MULTIPLE)
        }
        self._imageView_1.layer.masksToBounds = true
        self._imageView_1.layer.cornerRadius = 15.0
        self._imageView_1.layer.borderWidth = 1.0
        self._imageView_1.layer.borderColor = Pairby.Colors.BLUE_GRAY_50.cgColor
        self._imageView_1.pin_setImage(from: URL(string: message.mediaItems![0]))
        
        // set up second imageview
        self._imageView_2 = FLAnimatedImageView()
        self.contentView.addSubview(self._imageView_2)
        self._imageView_2.snp.makeConstraints { make -> Void in
            make.top.equalTo(self.contentView).offset(Pairby.MessageUI.MARGIN_VERTICAL)
            make.bottom.equalTo(self.contentView).offset(-Pairby.MessageUI.MARGIN_VERTICAL)
            make.height.equalTo(Pairby.MessageUI.HEIGHT_MEDIA_MULTIPLE)
            make.width.equalTo(Pairby.MessageUI.HEIGHT_MEDIA_MULTIPLE)
            make.left.equalTo(self._imageView_1.snp.right).offset(5)
        }
        self._imageView_2.layer.masksToBounds = true
        self._imageView_2.layer.cornerRadius = 15.0
        self._imageView_2.layer.borderWidth = 1.0
        self._imageView_2.layer.borderColor = Pairby.Colors.BLUE_GRAY_50.cgColor
        self._imageView_2.pin_setImage(from: URL(string: message.mediaItems![1]))
        
        // set up third imageview
        self._imageView_3 = FLAnimatedImageView()
        self.contentView.addSubview(self._imageView_3)
        self._imageView_3.snp.makeConstraints { make -> Void in
            make.top.equalTo(self.contentView).offset(Pairby.MessageUI.MARGIN_VERTICAL)
            make.bottom.equalTo(self.contentView).offset(-Pairby.MessageUI.MARGIN_VERTICAL)
            make.height.equalTo(Pairby.MessageUI.HEIGHT_MEDIA_MULTIPLE)
            make.width.equalTo(Pairby.MessageUI.HEIGHT_MEDIA_MULTIPLE)
            make.left.equalTo(self._imageView_2.snp.right).offset(5)
        }
        self._imageView_3.layer.masksToBounds = true
        self._imageView_3.layer.cornerRadius = 15.0
        self._imageView_3.layer.borderWidth = 1.0
        self._imageView_3.layer.borderColor = Pairby.Colors.BLUE_GRAY_50.cgColor
        self._imageView_3.pin_setImage(from: URL(string: message.mediaItems![2]))
        
        // set alignment depending on message direction
        if message.direction == "out" {
            self._imageView_3.snp.makeConstraints { make -> Void in
                make.right.equalTo(self.contentView).offset(-Pairby.MessageUI.MARGIN_HORIZONTAL)
            }
        } else {
            self._imageView_1.snp.makeConstraints { make -> Void in
                make.left.equalTo(self.contentView).offset(Pairby.MessageUI.MARGIN_HORIZONTAL)
            }
        }
    }
    
}

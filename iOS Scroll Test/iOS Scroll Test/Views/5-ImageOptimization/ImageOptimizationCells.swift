import UIKit
import SnapKit
import PINRemoteImage

// ---------------------------
// -- TEXT CELL | OUT
// ---------------------------
class ImageOptimization_TextCell_Out: ReusableCell {

    private var _messageLabelWrap: UIView!
    private var _messageLabel: UILabel!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // set up wrapper
        self._messageLabelWrap = UIView()
        self.contentView.addSubview(self._messageLabelWrap)
        self._messageLabelWrap.snp.makeConstraints { make -> Void in
            make.top.equalTo(self.contentView).offset(Pairby.MessageUI.MARGIN_VERTICAL_WRAP)
            make.right.equalTo(self.contentView).offset(-Pairby.MessageUI.MARGIN_HORIZONTAL_WRAP_FIXED)
            make.bottom.equalTo(self.contentView).offset(-Pairby.MessageUI.MARGIN_VERTICAL_WRAP)
            make.left.greaterThanOrEqualTo(self.contentView).offset(Pairby.MessageUI.MARGIN_HORIZONTAL_WRAP_DYNAMIC)
        }
        self._messageLabelWrap.layer.masksToBounds = true
        self._messageLabelWrap.layer.cornerRadius = 15.0
        self._messageLabelWrap.backgroundColor = Pairby.Colors.TEAL

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
        self._messageLabel.textColor = UIColor.white
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateFromMessage(message: Message) {
        self._messageLabel.text = message.message
    }

}

// ---------------------------
// -- TEXT CELL | IN
// ---------------------------
class ImageOptimization_TextCell_In: ReusableCell {

    private var _messageLabelWrap: UIView!
    private var _messageLabel: UILabel!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // set up wrapper
        self._messageLabelWrap = UIView()
        self.contentView.addSubview(self._messageLabelWrap)
        self._messageLabelWrap.snp.makeConstraints { make -> Void in
            make.top.equalTo(self.contentView).offset(Pairby.MessageUI.MARGIN_VERTICAL_WRAP)
            make.right.lessThanOrEqualTo(self.contentView).offset(Pairby.MessageUI.MARGIN_HORIZONTAL_WRAP_DYNAMIC)
            make.bottom.equalTo(self.contentView).offset(-Pairby.MessageUI.MARGIN_VERTICAL_WRAP)
            make.left.equalTo(self.contentView).offset(Pairby.MessageUI.MARGIN_HORIZONTAL_WRAP_FIXED)
        }
        self._messageLabelWrap.layer.masksToBounds = true
        self._messageLabelWrap.layer.cornerRadius = 15.0
        self._messageLabelWrap.backgroundColor = Pairby.Colors.BLUE_GRAY_50

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
        self._messageLabel.textColor = Pairby.Colors.BLUE_GRAY_700
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateFromMessage(message: Message) {
        self._messageLabel.text = message.message
    }

}

// ---------------------------
// -- MEDIA CELL | 1 | OUT
// ---------------------------
class ImageOptimization_MediaCell_1_Out: ReusableCell {

    private var _imageView: FLAnimatedImageView!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // set up imageview
        self._imageView = FLAnimatedImageView()
        self.contentView.addSubview(self._imageView)
        self._imageView.snp.makeConstraints { make -> Void in
            make.top.equalTo(self.contentView).offset(Pairby.MessageUI.MARGIN_VERTICAL_WRAP)
            make.bottom.equalTo(self.contentView).offset(-Pairby.MessageUI.MARGIN_VERTICAL_WRAP)
            make.left.equalTo(self.contentView).offset(Pairby.MessageUI.MARGIN_HORIZONTAL_WRAP_FIXED)
            make.width.equalTo(self._imageView.snp.height)
        }
        self._imageView.layer.masksToBounds = true
        self._imageView.layer.cornerRadius = 15.0
        self._imageView.layer.borderWidth = 1.0
        self._imageView.layer.borderColor = Pairby.Colors.BLUE_GRAY_50.cgColor
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateFromMessage(message: Message) {
        ImageOptimizer.handleAndSetImage(imageView: self._imageView, urlString: message.mediaItems![0], size: Pairby.MessageUI.HEIGHT_MEDIA_ONE)
    }

}

// ---------------------------
// -- MEDIA CELL | 1 | IN
// ---------------------------
class ImageOptimization_MediaCell_1_In: ReusableCell {

    private var _imageView: FLAnimatedImageView!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // set up imageview
        self._imageView = FLAnimatedImageView()
        self.contentView.addSubview(self._imageView)
        self._imageView.snp.makeConstraints { make -> Void in
            make.top.equalTo(self.contentView).offset(Pairby.MessageUI.MARGIN_VERTICAL_WRAP)
            make.right.equalTo(self.contentView).offset(-Pairby.MessageUI.MARGIN_HORIZONTAL_WRAP_FIXED)
            make.bottom.equalTo(self.contentView).offset(-Pairby.MessageUI.MARGIN_VERTICAL_WRAP)
            make.width.equalTo(self._imageView.snp.height)
        }
        self._imageView.layer.masksToBounds = true
        self._imageView.layer.cornerRadius = 15.0
        self._imageView.layer.borderWidth = 1.0
        self._imageView.layer.borderColor = Pairby.Colors.BLUE_GRAY_50.cgColor
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateFromMessage(message: Message) {
        ImageOptimizer.handleAndSetImage(imageView: self._imageView, urlString: message.mediaItems![0], size: Pairby.MessageUI.HEIGHT_MEDIA_ONE)
    }

}

// ---------------------------
// -- MEDIA CELL | 2 | OUT
// ---------------------------
class ImageOptimization_MediaCell_2_Out: ReusableCell {

    private var _imageView_1: FLAnimatedImageView!
    private var _imageView_2: FLAnimatedImageView!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // set up first imageview
        self._imageView_1 = FLAnimatedImageView()
        self.contentView.addSubview(self._imageView_1)
        self._imageView_1.snp.makeConstraints { make -> Void in
            make.top.equalTo(self.contentView).offset(Pairby.MessageUI.MARGIN_VERTICAL_WRAP)
            make.bottom.equalTo(self.contentView).offset(-Pairby.MessageUI.MARGIN_VERTICAL_WRAP)
            make.height.equalTo(Pairby.MessageUI.HEIGHT_MEDIA_MULTIPLE)
            make.width.equalTo(Pairby.MessageUI.HEIGHT_MEDIA_MULTIPLE)
        }
        self._imageView_1.layer.masksToBounds = true
        self._imageView_1.layer.cornerRadius = 15.0
        self._imageView_1.layer.borderWidth = 1.0
        self._imageView_1.layer.borderColor = Pairby.Colors.BLUE_GRAY_50.cgColor

        // set up second imageview
        self._imageView_2 = FLAnimatedImageView()
        self.contentView.addSubview(self._imageView_2)
        self._imageView_2.snp.makeConstraints { make -> Void in
            make.top.equalTo(self.contentView).offset(Pairby.MessageUI.MARGIN_VERTICAL_WRAP)
            make.right.equalTo(self.contentView).offset(-Pairby.MessageUI.MARGIN_HORIZONTAL_WRAP_FIXED)
            make.bottom.equalTo(self.contentView).offset(-Pairby.MessageUI.MARGIN_VERTICAL_WRAP)
            make.left.equalTo(self._imageView_1.snp.right).offset(5)
            make.width.equalTo(self._imageView_1.snp.height)
        }
        self._imageView_2.layer.masksToBounds = true
        self._imageView_2.layer.cornerRadius = 15.0
        self._imageView_2.layer.borderWidth = 1.0
        self._imageView_2.layer.borderColor = Pairby.Colors.BLUE_GRAY_50.cgColor
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateFromMessage(message: Message) {
        ImageOptimizer.handleAndSetImage(imageView: self._imageView_1, urlString: message.mediaItems![0], size: Pairby.MessageUI.HEIGHT_MEDIA_MULTIPLE)
        ImageOptimizer.handleAndSetImage(imageView: self._imageView_2, urlString: message.mediaItems![1], size: Pairby.MessageUI.HEIGHT_MEDIA_MULTIPLE)
    }

}

// ---------------------------
// -- MEDIA CELL | 2 | IN
// ---------------------------
class ImageOptimization_MediaCell_2_In: ReusableCell {

    private var _imageView_1: FLAnimatedImageView!
    private var _imageView_2: FLAnimatedImageView!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // set up first imageview
        self._imageView_1 = FLAnimatedImageView()
        self.contentView.addSubview(self._imageView_1)
        self._imageView_1.snp.makeConstraints { make -> Void in
            make.top.equalTo(self.contentView).offset(Pairby.MessageUI.MARGIN_VERTICAL_WRAP)
            make.bottom.equalTo(self.contentView).offset(-Pairby.MessageUI.MARGIN_VERTICAL_WRAP)
            make.left.equalTo(self.contentView).offset(Pairby.MessageUI.MARGIN_HORIZONTAL_WRAP_FIXED)
            make.width.equalTo(self._imageView_1.snp.height)
        }
        self._imageView_1.layer.masksToBounds = true
        self._imageView_1.layer.cornerRadius = 15.0
        self._imageView_1.layer.borderWidth = 1.0
        self._imageView_1.layer.borderColor = Pairby.Colors.BLUE_GRAY_50.cgColor

        // set up second imageview
        self._imageView_2 = FLAnimatedImageView()
        self.contentView.addSubview(self._imageView_2)
        self._imageView_2.snp.makeConstraints { make -> Void in
            make.top.equalTo(self.contentView).offset(Pairby.MessageUI.MARGIN_VERTICAL_WRAP)
            make.bottom.equalTo(self.contentView).offset(-Pairby.MessageUI.MARGIN_VERTICAL_WRAP)
            make.left.equalTo(self._imageView_1.snp.right).offset(5)
            make.width.equalTo(self._imageView_2.snp.height)
        }
        self._imageView_2.layer.masksToBounds = true
        self._imageView_2.layer.cornerRadius = 15.0
        self._imageView_2.layer.borderWidth = 1.0
        self._imageView_2.layer.borderColor = Pairby.Colors.BLUE_GRAY_50.cgColor
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateFromMessage(message: Message) {
        ImageOptimizer.handleAndSetImage(imageView: self._imageView_1, urlString: message.mediaItems![0], size: Pairby.MessageUI.HEIGHT_MEDIA_MULTIPLE)
        ImageOptimizer.handleAndSetImage(imageView: self._imageView_2, urlString: message.mediaItems![1], size: Pairby.MessageUI.HEIGHT_MEDIA_MULTIPLE)
    }

}

// ---------------------------
// -- MEDIA CELL | 3 | OUT
// ---------------------------
class ImageOptimization_MediaCell_3_Out: ReusableCell {

    private var _imageView_1: FLAnimatedImageView!
    private var _imageView_2: FLAnimatedImageView!
    private var _imageView_3: FLAnimatedImageView!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // set up first imageview
        self._imageView_1 = FLAnimatedImageView()
        self.contentView.addSubview(self._imageView_1)
        self._imageView_1.snp.makeConstraints { make -> Void in
            make.top.equalTo(self.contentView).offset(Pairby.MessageUI.MARGIN_VERTICAL_WRAP)
            make.bottom.equalTo(self.contentView).offset(-Pairby.MessageUI.MARGIN_VERTICAL_WRAP)
            make.width.equalTo(self._imageView_1.snp.height)
        }
        self._imageView_1.layer.masksToBounds = true
        self._imageView_1.layer.cornerRadius = 15.0
        self._imageView_1.layer.borderWidth = 1.0
        self._imageView_1.layer.borderColor = Pairby.Colors.BLUE_GRAY_50.cgColor

        // set up second imageview
        self._imageView_2 = FLAnimatedImageView()
        self.contentView.addSubview(self._imageView_2)
        self._imageView_2.snp.makeConstraints { make -> Void in
            make.top.equalTo(self.contentView).offset(Pairby.MessageUI.MARGIN_VERTICAL_WRAP)
            make.bottom.equalTo(self.contentView).offset(-Pairby.MessageUI.MARGIN_VERTICAL_WRAP)
            make.left.equalTo(self._imageView_1.snp.right).offset(5)
            make.width.equalTo(self._imageView_2.snp.height)
        }
        self._imageView_2.layer.masksToBounds = true
        self._imageView_2.layer.cornerRadius = 15.0
        self._imageView_2.layer.borderWidth = 1.0
        self._imageView_2.layer.borderColor = Pairby.Colors.BLUE_GRAY_50.cgColor

        // set up third imageview
        self._imageView_3 = FLAnimatedImageView()
        self.contentView.addSubview(self._imageView_3)
        self._imageView_3.snp.makeConstraints { make -> Void in
            make.top.equalTo(self.contentView).offset(Pairby.MessageUI.MARGIN_VERTICAL_WRAP)
            make.right.equalTo(self.contentView).offset(-Pairby.MessageUI.MARGIN_HORIZONTAL_WRAP_FIXED)
            make.bottom.equalTo(self.contentView).offset(-Pairby.MessageUI.MARGIN_VERTICAL_WRAP)
            make.left.equalTo(self._imageView_2.snp.right).offset(5)
            make.width.equalTo(self._imageView_3.snp.height)
        }
        self._imageView_3.layer.masksToBounds = true
        self._imageView_3.layer.cornerRadius = 15.0
        self._imageView_3.layer.borderWidth = 1.0
        self._imageView_3.layer.borderColor = Pairby.Colors.BLUE_GRAY_50.cgColor
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateFromMessage(message: Message) {
        ImageOptimizer.handleAndSetImage(imageView: self._imageView_1, urlString: message.mediaItems![0], size: Pairby.MessageUI.HEIGHT_MEDIA_MULTIPLE)
        ImageOptimizer.handleAndSetImage(imageView: self._imageView_2, urlString: message.mediaItems![1], size: Pairby.MessageUI.HEIGHT_MEDIA_MULTIPLE)
        ImageOptimizer.handleAndSetImage(imageView: self._imageView_3, urlString: message.mediaItems![2], size: Pairby.MessageUI.HEIGHT_MEDIA_MULTIPLE)
    }

}

// ---------------------------
// -- MEDIA CELL | 3 | IN
// ---------------------------
class ImageOptimization_MediaCell_3_In: ReusableCell {

    private var _imageView_1: FLAnimatedImageView!
    private var _imageView_2: FLAnimatedImageView!
    private var _imageView_3: FLAnimatedImageView!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // set up first imageview
        self._imageView_1 = FLAnimatedImageView()
        self.contentView.addSubview(self._imageView_1)
        self._imageView_1.snp.makeConstraints { make -> Void in
            make.top.equalTo(self.contentView).offset(Pairby.MessageUI.MARGIN_VERTICAL_WRAP)
            make.bottom.equalTo(self.contentView).offset(-Pairby.MessageUI.MARGIN_VERTICAL_WRAP)
            make.left.equalTo(self.contentView).offset(Pairby.MessageUI.MARGIN_HORIZONTAL_WRAP_FIXED)
            make.width.equalTo(self._imageView_1.snp.height)
        }
        self._imageView_1.layer.masksToBounds = true
        self._imageView_1.layer.cornerRadius = 15.0
        self._imageView_1.layer.borderWidth = 1.0
        self._imageView_1.layer.borderColor = Pairby.Colors.BLUE_GRAY_50.cgColor

        // set up second imageview
        self._imageView_2 = FLAnimatedImageView()
        self.contentView.addSubview(self._imageView_2)
        self._imageView_2.snp.makeConstraints { make -> Void in
            make.top.equalTo(self.contentView).offset(Pairby.MessageUI.MARGIN_VERTICAL_WRAP)
            make.bottom.equalTo(self.contentView).offset(-Pairby.MessageUI.MARGIN_VERTICAL_WRAP)
            make.left.equalTo(self._imageView_1.snp.right).offset(5)
            make.width.equalTo(self._imageView_2.snp.height)
        }
        self._imageView_2.layer.masksToBounds = true
        self._imageView_2.layer.cornerRadius = 15.0
        self._imageView_2.layer.borderWidth = 1.0
        self._imageView_2.layer.borderColor = Pairby.Colors.BLUE_GRAY_50.cgColor

        // set up third imageview
        self._imageView_3 = FLAnimatedImageView()
        self.contentView.addSubview(self._imageView_3)
        self._imageView_3.snp.makeConstraints { make -> Void in
            make.top.equalTo(self.contentView).offset(Pairby.MessageUI.MARGIN_VERTICAL_WRAP)
            make.bottom.equalTo(self.contentView).offset(-Pairby.MessageUI.MARGIN_VERTICAL_WRAP)
            make.left.equalTo(self._imageView_2.snp.right).offset(5)
            make.width.equalTo(self._imageView_3.snp.height)
        }
        self._imageView_3.layer.masksToBounds = true
        self._imageView_3.layer.cornerRadius = 15.0
        self._imageView_3.layer.borderWidth = 1.0
        self._imageView_3.layer.borderColor = Pairby.Colors.BLUE_GRAY_50.cgColor
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateFromMessage(message: Message) {
        ImageOptimizer.handleAndSetImage(imageView: self._imageView_1, urlString: message.mediaItems![0], size: Pairby.MessageUI.HEIGHT_MEDIA_MULTIPLE)
        ImageOptimizer.handleAndSetImage(imageView: self._imageView_2, urlString: message.mediaItems![1], size: Pairby.MessageUI.HEIGHT_MEDIA_MULTIPLE)
        ImageOptimizer.handleAndSetImage(imageView: self._imageView_3, urlString: message.mediaItems![2], size: Pairby.MessageUI.HEIGHT_MEDIA_MULTIPLE)
    }

}

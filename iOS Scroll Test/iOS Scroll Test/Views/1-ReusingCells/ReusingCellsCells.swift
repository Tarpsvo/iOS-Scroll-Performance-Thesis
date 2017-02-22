import UIKit
import SnapKit
import PINRemoteImage

// -----------------
// -- TEXT CELL
// -----------------
class ReusingCells_TextCell: ReusableCell {
    
    private var _messageLabelWrap: UIView!
    private var _messageLabel: UILabel!
    private var _leftConstraint: Constraint?
    private var _rightConstraint: Constraint?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // set up wrapper
        self._messageLabelWrap = UIView()
        self.contentView.addSubview(self._messageLabelWrap)
        self._messageLabelWrap.snp.makeConstraints { make -> Void in
            make.top.equalTo(self.contentView).offset(5)
            make.bottom.equalTo(self.contentView).offset(-5)
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateFromMessage(message: Message) {
        // clear existing alignment constraints
        if let c = self._leftConstraint { c.deactivate() }
        if let c = self._rightConstraint { c.deactivate() }
        
        // set alignment and colors according to message direction
        if (message.direction == "out") {
            // alignment
            self._messageLabelWrap.snp.makeConstraints { make -> Void in
                self._leftConstraint = make.left.greaterThanOrEqualTo(self.contentView).offset(Pairby.MessageUI.MARGIN_HORIZONTAL_WRAP_DYNAMIC).constraint
                self._rightConstraint = make.right.equalTo(self.contentView).offset(-Pairby.MessageUI.MARGIN_HORIZONTAL_WRAP_FIXED).constraint
            }
        } else {
            // alignment
            self._messageLabelWrap.snp.makeConstraints { make -> Void in
                self._leftConstraint = make.left.equalTo(self.contentView).offset(Pairby.MessageUI.MARGIN_HORIZONTAL_WRAP_FIXED).constraint
                self._rightConstraint = make.right.lessThanOrEqualTo(self.contentView).offset(-Pairby.MessageUI.MARGIN_HORIZONTAL_WRAP_DYNAMIC).constraint
            }
        }
        
        // set colors according to message alignment
        if (message.direction == "out") {
            self._messageLabelWrap.backgroundColor = Pairby.Colors.TEAL
            self._messageLabel.textColor = UIColor.white
        } else {
            self._messageLabelWrap.backgroundColor = Pairby.Colors.BLUE_GRAY_50
            self._messageLabel.textColor = Pairby.Colors.BLUE_GRAY_700
        }
        
        // set text
        self._messageLabel.text = message.message
    }
    
}

// -----------------
// -- MEDIA CELL
// -----------------
class ReusingCells_MediaCell: ReusableCell {
    
    private var _imageView_1: FLAnimatedImageView!
    private var _imageView_2: FLAnimatedImageView!
    private var _imageView_3: FLAnimatedImageView!
    private var _edgeConstraint: Constraint?
    private var _twoMediaItemConnectorConstraint: Constraint?
    private var _threeMediaItemConnectorConstraint_1: Constraint?
    private var _threeMediaItemConnectorConstraint_2: Constraint?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self._imageView_1 = FLAnimatedImageView()
        self._imageView_1.layer.masksToBounds = true
        self._imageView_1.layer.cornerRadius = 15.0
        self._imageView_1.layer.borderWidth = 1.0
        self._imageView_1.layer.borderColor = Pairby.Colors.BLUE_GRAY_50.cgColor
        
        self._imageView_2 = FLAnimatedImageView()
        self._imageView_2.layer.masksToBounds = true
        self._imageView_2.layer.cornerRadius = 15.0
        self._imageView_2.layer.borderWidth = 1.0
        self._imageView_2.layer.borderColor = Pairby.Colors.BLUE_GRAY_50.cgColor
        
        self._imageView_3 = FLAnimatedImageView()
        self._imageView_3.layer.masksToBounds = true
        self._imageView_3.layer.cornerRadius = 15.0
        self._imageView_3.layer.borderWidth = 1.0
        self._imageView_3.layer.borderColor = Pairby.Colors.BLUE_GRAY_50.cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup_imageView(n: Int) {
        let imageView: UIImageView! = (n == 1) ? self._imageView_1 : (n == 2) ? self._imageView_2 : self._imageView_3
        
        // clear image state
        imageView.pin_clearImages()
        
        // if not in contentview, then add it and create constraints
        if (imageView.superview == nil) {
            self.contentView.addSubview(imageView)
            imageView.snp.makeConstraints { make -> Void in
                make.top.equalTo(self.contentView).offset(Pairby.MessageUI.MARGIN_VERTICAL_WRAP)
                make.bottom.equalTo(self.contentView).offset(-Pairby.MessageUI.MARGIN_VERTICAL_WRAP)
                make.width.equalTo(imageView.snp.height)
            }
        }
    }
    
    private func clearState_imageView(n: Int) {
        let imageView: UIImageView! = (n == 1) ? self._imageView_1 : (n == 2) ? self._imageView_2 : self._imageView_3
        
        // if it is in a view, remove it
        if (imageView.superview != nil) {
            // self._imageView_2.snp.removeConstraints()
            imageView.removeFromSuperview()
        }
    }
    
    private func setup_contentView(multiple: Bool) {
        self.contentView.snp.updateConstraints { make -> Void in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(((multiple) ? Pairby.MessageUI.HEIGHT_MEDIA_MULTIPLE : Pairby.MessageUI.HEIGHT_MEDIA_ONE) + (2 * Pairby.MessageUI.MARGIN_VERTICAL_WRAP))
        }
    }
    
    private func clearState_edgeAndConnectorConstraints() {
        if let c = self._edgeConstraint { c.deactivate() }
        if let c = self._twoMediaItemConnectorConstraint { c.deactivate() }
        if let c = self._threeMediaItemConnectorConstraint_1 { c.deactivate() }
        if let c = self._threeMediaItemConnectorConstraint_2 { c.deactivate() }
    }

    // ------ ONE MEDIA ITEM
    private func setup_oneMediaItem(message: Message) {
        // do view setups
        self.clearState_edgeAndConnectorConstraints()
        self.setup_contentView(multiple: false)
        self.setup_imageView(n: 1)
        self.clearState_imageView(n: 2)
        self.clearState_imageView(n: 3)

        // set image
        self._imageView_1.pin_setImage(from: URL(string: message.mediaItems![0]))
        
        // set alignment depending on message direction
        self._imageView_1.snp.makeConstraints { make -> Void in
            self._edgeConstraint = (message.direction == "out")
                ? make.right.equalTo(self.contentView).offset(-Pairby.MessageUI.MARGIN_HORIZONTAL).constraint
                : make.left.equalTo(self.contentView).offset(Pairby.MessageUI.MARGIN_HORIZONTAL).constraint
        }
    }
    
    // ------ TWO MEDIA ITEMS
    private func setup_twoMediaItems(message: Message) {
        // do view setups
        self.clearState_edgeAndConnectorConstraints()
        self.setup_contentView(multiple: true)
        self.setup_imageView(n: 1)
        self.setup_imageView(n: 2)
        self.clearState_imageView(n: 3)
        
        // set images
        self._imageView_1.pin_setImage(from: URL(string: message.mediaItems![0]))
        self._imageView_2.pin_setImage(from: URL(string: message.mediaItems![1]))

        // create specific constraints
        self._imageView_2.snp.makeConstraints { make -> Void in
            self._twoMediaItemConnectorConstraint = make.left.equalTo(self._imageView_1.snp.right).offset(5).constraint
        }
        
        // set alignment depending on message direction
        if (message.direction == "out") {
            self._imageView_2.snp.makeConstraints { make -> Void in
                self._edgeConstraint = make.right.equalTo(self.contentView).offset(-Pairby.MessageUI.MARGIN_HORIZONTAL).constraint
            }
        } else {
            self._imageView_1.snp.makeConstraints { make -> Void in
                self._edgeConstraint = make.left.equalTo(self.contentView).offset(Pairby.MessageUI.MARGIN_HORIZONTAL).constraint
            }
        }
    }
    
    // ------ THREE MEDIA ITEMS
    private func setup_threeMediaItems(message: Message) {
        /// do view setups
        self.clearState_edgeAndConnectorConstraints()
        self.setup_contentView(multiple: true)
        self.setup_imageView(n: 1)
        self.setup_imageView(n: 2)
        self.setup_imageView(n: 3)
        
        // set images
        self._imageView_1.pin_setImage(from: URL(string: message.mediaItems![0]))
        self._imageView_2.pin_setImage(from: URL(string: message.mediaItems![1]))
        self._imageView_3.pin_setImage(from: URL(string: message.mediaItems![2]))
        
        // create specific constraints
        self._imageView_2.snp.makeConstraints { make -> Void in
            self._threeMediaItemConnectorConstraint_1 = make.left.equalTo(self._imageView_1.snp.right).offset(5).constraint
        }
        
        self._imageView_3.snp.makeConstraints { make -> Void in
            self._threeMediaItemConnectorConstraint_2 = make.left.equalTo(self._imageView_2.snp.right).offset(5).constraint
        }

        
        // set alignment depending on message direction
        if (message.direction == "out") {
            self._imageView_3.snp.makeConstraints { make -> Void in
                self._edgeConstraint = make.right.equalTo(self.contentView).offset(-Pairby.MessageUI.MARGIN_HORIZONTAL).constraint
            }
        } else {
            self._imageView_1.snp.makeConstraints { make -> Void in
                self._edgeConstraint = make.left.equalTo(self.contentView).offset(Pairby.MessageUI.MARGIN_HORIZONTAL).constraint
            }
        }
    }
    
    override func updateFromMessage(message: Message) {
        if let mediaItems = message.mediaItems {
            if (mediaItems.count == 1) { self.setup_oneMediaItem(message: message) }
            if (mediaItems.count == 2) { self.setup_twoMediaItems(message: message) }
            if (mediaItems.count == 3) { self.setup_threeMediaItems(message: message) }
        }
    }
    
}


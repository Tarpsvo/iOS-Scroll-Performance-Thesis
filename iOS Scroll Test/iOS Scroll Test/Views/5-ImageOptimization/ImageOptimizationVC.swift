import UIKit

class ImageOptimizationVC: BaseVC, UITableViewDelegate, UITableViewDataSource {

    private var _heightCache: [Int: CGFloat] = [:]

    override init() {
        super.init()
        self.title = "ImageOptimizationVC"
        self._tableView.delegate = self
        self._tableView.dataSource = self
        self._tableView.allowsSelection = false
        self._tableView.register(ImageOptimization_TextCell_In.self, forCellReuseIdentifier: "ImageOptimization_TextCell_In")
        self._tableView.register(ImageOptimization_TextCell_Out.self, forCellReuseIdentifier: "ImageOptimization_TextCell_Out")
        self._tableView.register(ImageOptimization_MediaCell_1_In.self, forCellReuseIdentifier: "ImageOptimization_MediaCell_1_In")
        self._tableView.register(ImageOptimization_MediaCell_1_Out.self, forCellReuseIdentifier: "ImageOptimization_MediaCell_1_Out")
        self._tableView.register(ImageOptimization_MediaCell_2_In.self, forCellReuseIdentifier: "ImageOptimization_MediaCell_2_In")
        self._tableView.register(ImageOptimization_MediaCell_2_Out.self, forCellReuseIdentifier: "ImageOptimization_MediaCell_2_Out")
        self._tableView.register(ImageOptimization_MediaCell_3_In.self, forCellReuseIdentifier: "ImageOptimization_MediaCell_3_In")
        self._tableView.register(ImageOptimization_MediaCell_3_Out.self, forCellReuseIdentifier: "ImageOptimization_MediaCell_3_Out")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self._messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = self._messages[indexPath.row]

        var cellIdentifier = "ImageOptimization_TextCell_\(message.direction.capitalized)"
        if let mediaItems = message.mediaItems {
            if (mediaItems.count == 1) { cellIdentifier = "ImageOptimization_MediaCell_1_\(message.direction.capitalized)" }
            if (mediaItems.count == 2) { cellIdentifier = "ImageOptimization_MediaCell_2_\(message.direction.capitalized)" }
            if (mediaItems.count == 3) { cellIdentifier = "ImageOptimization_MediaCell_3_\(message.direction.capitalized)" }
        }

        let cell = self._tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ReusableCell
        cell.updateFromMessage(message: message)
        return cell as! UITableViewCell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let height = self._heightCache[indexPath.row] { return height }
        let message = self._messages[indexPath.row]
        if let mediaItems = message.mediaItems {
            let baseHeight = (mediaItems.count == 1) ? Pairby.MessageUI.HEIGHT_MEDIA_ONE : Pairby.MessageUI.HEIGHT_MEDIA_MULTIPLE
            let verticalMargin = (2 * Pairby.MessageUI.MARGIN_VERTICAL_WRAP)
            self._heightCache[indexPath.row] = (baseHeight + verticalMargin)
            return self._heightCache[indexPath.row]!
        }

        let MaxWidth = (self._tableView.frame.size.width - (2 * Pairby.MessageUI.MARGIN_HORIZONTAL) - Pairby.MessageUI.MARGIN_HORIZONTAL_WRAP_DYNAMIC - Pairby.MessageUI.MARGIN_HORIZONTAL_WRAP_FIXED)
        let HeightAdd = (2 * Pairby.MessageUI.MARGIN_VERTICAL + 2 * Pairby.MessageUI.MARGIN_VERTICAL_WRAP)
        let Height = ceil(message.message!.heightWithConstrainedWidth(width: MaxWidth, font: Pairby.MessageUI.TEXT_FONT))
        self._heightCache[indexPath.row] = (Height + HeightAdd)
        return self._heightCache[indexPath.row]!
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if let height = self._heightCache[indexPath.row] { return height }
        let message = self._messages[indexPath.row]
        if let mediaItems = message.mediaItems {
            let baseHeight = (mediaItems.count == 1) ? Pairby.MessageUI.HEIGHT_MEDIA_ONE : Pairby.MessageUI.HEIGHT_MEDIA_MULTIPLE
            let verticalMargin = (2 * Pairby.MessageUI.MARGIN_VERTICAL)
            return (baseHeight + verticalMargin)
        }
        return 44.0
    }

}

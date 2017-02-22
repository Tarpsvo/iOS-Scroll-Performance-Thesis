import UIKit

class ManualHeightCalcVC: BaseVC, UITableViewDelegate, UITableViewDataSource {
    
    override init() {
        super.init()
        self.title = "ManualHeightCalcVC"
        self._tableView.delegate = self
        self._tableView.dataSource = self
        self._tableView.allowsSelection = false
        self._tableView.register(StaticCells_TextCell_In.self, forCellReuseIdentifier: "StaticCells_TextCell_In")
        self._tableView.register(StaticCells_TextCell_Out.self, forCellReuseIdentifier: "StaticCells_TextCell_Out")
        self._tableView.register(StaticCells_MediaCell_1_In.self, forCellReuseIdentifier: "StaticCells_MediaCell_1_In")
        self._tableView.register(StaticCells_MediaCell_1_Out.self, forCellReuseIdentifier: "StaticCells_MediaCell_1_Out")
        self._tableView.register(StaticCells_MediaCell_2_In.self, forCellReuseIdentifier: "StaticCells_MediaCell_2_In")
        self._tableView.register(StaticCells_MediaCell_2_Out.self, forCellReuseIdentifier: "StaticCells_MediaCell_2_Out")
        self._tableView.register(StaticCells_MediaCell_3_In.self, forCellReuseIdentifier: "StaticCells_MediaCell_3_In")
        self._tableView.register(StaticCells_MediaCell_3_Out.self, forCellReuseIdentifier: "StaticCells_MediaCell_3_Out")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self._messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = self._messages[indexPath.row]
        
        var cellIdentifier = "StaticCells_TextCell_\(message.direction.capitalized)"
        if (message.mediaItems != nil) {
            if (message.mediaItems!.count == 1) { cellIdentifier = "StaticCells_MediaCell_1_\(message.direction.capitalized)" }
            if (message.mediaItems!.count == 2) { cellIdentifier = "StaticCells_MediaCell_2_\(message.direction.capitalized)" }
            if (message.mediaItems!.count == 3) { cellIdentifier = "StaticCells_MediaCell_3_\(message.direction.capitalized)" }
        }
        
        let cell = self._tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ReusableCell
        cell.updateFromMessage(message: message)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let message = self._messages[indexPath.row]
        if let mediaItems = message.mediaItems {
            let baseHeight = (mediaItems.count == 1) ? Pairby.MessageUI.HEIGHT_MEDIA_ONE : Pairby.MessageUI.HEIGHT_MEDIA_MULTIPLE
            let verticalMargin = (2 * Pairby.MessageUI.MARGIN_VERTICAL_WRAP)
            return (baseHeight + verticalMargin)
        }
        
        let MaxWidth = (self._tableView.frame.size.width - (2 * Pairby.MessageUI.MARGIN_HORIZONTAL) - Pairby.MessageUI.MARGIN_HORIZONTAL_WRAP_DYNAMIC - Pairby.MessageUI.MARGIN_HORIZONTAL_WRAP_FIXED)
        let HeightAdd = (2 * Pairby.MessageUI.MARGIN_VERTICAL + 2 * Pairby.MessageUI.MARGIN_VERTICAL_WRAP)
        let Height = ceil(message.message!.heightWithConstrainedWidth(width: MaxWidth, font: Pairby.MessageUI.TEXT_FONT))
        return (Height + HeightAdd)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let message = self._messages[indexPath.row]
        if let mediaItems = message.mediaItems {
            let baseHeight = (mediaItems.count == 1) ? Pairby.MessageUI.HEIGHT_MEDIA_ONE : Pairby.MessageUI.HEIGHT_MEDIA_MULTIPLE
            let verticalMargin = (2 * Pairby.MessageUI.MARGIN_VERTICAL)
            return (baseHeight + verticalMargin)
        }
        return 44.0
    }
    
}

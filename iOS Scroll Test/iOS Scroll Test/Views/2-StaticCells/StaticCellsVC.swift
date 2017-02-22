import UIKit

class StaticCellsVC: BaseVC, UITableViewDelegate, UITableViewDataSource {
    
    override init() {
        super.init()
        self.title = "StaticCellsVC"
        self._tableView.delegate = self
        self._tableView.dataSource = self
        self._tableView.estimatedRowHeight = 44.0
        self._tableView.rowHeight = UITableViewAutomaticDimension
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
    
}

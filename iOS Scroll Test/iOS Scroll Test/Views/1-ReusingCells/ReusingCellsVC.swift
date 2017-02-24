import UIKit

class ReusingCellsVC: BaseVC, UITableViewDelegate, UITableViewDataSource {
    
    override init() {
        super.init()
        self.title = "ReusingCellsVC"
        self._tableView.delegate = self
        self._tableView.dataSource = self
        self._tableView.estimatedRowHeight = 44.0
        self._tableView.rowHeight = UITableViewAutomaticDimension
        self._tableView.allowsSelection = false
        self._tableView.register(ReusingCells_TextCell.self, forCellReuseIdentifier: "ReusingCells_TextCell")
        self._tableView.register(ReusingCells_MediaCell.self, forCellReuseIdentifier: "ReusingCells_MediaCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self._messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = self._messages[indexPath.row]
        let cellIdentifier = (message.mediaItems == nil) ? "ReusingCells_TextCell" : "ReusingCells_MediaCell"
        let cell = self._tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! ReusableCell
        cell.updateFromMessage(message: message)
        return cell
    }
    
}

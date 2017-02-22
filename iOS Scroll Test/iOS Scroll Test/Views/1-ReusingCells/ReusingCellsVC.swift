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
        
        if (message.mediaItems != nil) {
            let cell = self._tableView.dequeueReusableCell(withIdentifier: "ReusingCells_MediaCell", for: indexPath) as! ReusableCell
            cell.updateFromMessage(message: message)
            return cell
        }
        
        let cell = self._tableView.dequeueReusableCell(withIdentifier: "ReusingCells_TextCell", for: indexPath) as! ReusableCell
        cell.updateFromMessage(message: message)
        return cell
    }
    
}

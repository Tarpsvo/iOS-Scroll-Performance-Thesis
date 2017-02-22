import UIKit

class BestCaseScenarioVC: BaseVC, UITableViewDelegate, UITableViewDataSource {
    
    override init() {
        super.init()
        self.title = "BestCaseScenarioVC"
        self._tableView.delegate = self
        self._tableView.dataSource = self
        self._tableView.estimatedRowHeight = 44.0
        self._tableView.rowHeight = UITableViewAutomaticDimension
        self._tableView.allowsSelection = false
        self._tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BestCaseScenarioCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self._messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = self._messages[indexPath.row]
        let cell = self._tableView.dequeueReusableCell(withIdentifier: "BestCaseScenarioCell", for: indexPath)
        cell.textLabel?.text = (message.message != nil) ? message.message : "Media message with ID (\(message.id))"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}

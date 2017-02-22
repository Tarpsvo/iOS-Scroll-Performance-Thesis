import UIKit

class WorstCaseScenarioVC: BaseVC, UITableViewDelegate, UITableViewDataSource {
    
    override init() {
        super.init()
        self.title = "WorstCaseScenarioVC"
        self._tableView.delegate = self
        self._tableView.dataSource = self
        self._tableView.estimatedRowHeight = 44.0
        self._tableView.rowHeight = UITableViewAutomaticDimension
        self._tableView.allowsSelection = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self._messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = self._messages[indexPath.row]
        if message.message != nil { return WorstCaseScenario_TextCell(message: message) }
        return WorstCaseScenario_MediaCell(message: message)
    }
    
}

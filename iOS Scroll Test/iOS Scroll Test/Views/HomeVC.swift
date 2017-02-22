import UIKit

class HomeVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "HomeVC"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        
        // (0) BEST CASE SCENARIO
        if (row == 0) {
            cell.textLabel?.text = "0 - Best case scenario"
            cell.detailTextLabel?.text = ""
        }

        // (1) WORST CASE SCENARIO
        if (row == 1) {
            cell.textLabel?.text = "0 - Worst case scenario"
            cell.detailTextLabel?.text = ""
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row

        // (0) BEST CASE SCENARIO
        if (row == 0) { self.navigationController?.show(BestCaseScenarioVC(), sender: nil) }

        // (1) WORST CASE SCENARIO
        if (row == 1) { self.navigationController?.show(WorstCaseScenarioVC(), sender: nil) }
    }

}


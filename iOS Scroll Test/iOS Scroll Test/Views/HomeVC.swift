import UIKit

class HomeVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "HomeVC"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        // (0) BEST CASE SCENARIO
        if (row == 0) { cell.textLabel?.text = "0 - Best case scenario" }

        // (0) WORST CASE SCENARIO
        if (row == 1) { cell.textLabel?.text = "0 - Worst case scenario" }

        // (1) REUSING CELLS
        if (row == 2) { cell.textLabel?.text = "1 - Reusing cells" }

        // (2) STATIC CELLS
        if (row == 3) { cell.textLabel?.text = "2 - Static cells" }

        // (3) MANUAL HEIGHT CALCULATIONS
        if (row == 4) { cell.textLabel?.text = "3 - Manual height calculations" }

        // (4) HEIGHT CACHING
        if (row == 5) { cell.textLabel?.text = "4 - Height caching" }

        // (5) IMAGE OPTIMIZATIONS
        if (row == 6) { cell.textLabel?.text = "5 - Image optimizations" }

        // (6) LAYER RASTERIZATION
        if (row == 7) { cell.textLabel?.text = "6 - Layer rasterization" }

        // (7) NO OFFSCREEN RENDERING
        if (row == 8) { cell.textLabel?.text = "7 - No offscreen rendering" }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row

        // (0) BEST CASE SCENARIO
        if (row == 0) { self.navigationController?.show(BestCaseScenarioVC(), sender: nil) }

        // (0) WORST CASE SCENARIO
        if (row == 1) { self.navigationController?.show(WorstCaseScenarioVC(), sender: nil) }

        // (1) REUSING CELLS
        if (row == 2) { self.navigationController?.show(ReusingCellsVC(), sender: nil) }

        // (2) STATIC CELLS
        if (row == 3) { self.navigationController?.show(StaticCellsVC(), sender: nil) }

        // (3) MANUAL HEIGHT CALCULATIONS
        if (row == 4) { self.navigationController?.show(ManualHeightCalcVC(), sender: nil) }

        // (4) HEIGHT CACHING
        if (row == 5) { self.navigationController?.show(HeightCachingVC(), sender: nil) }

        // (5) IMAGE OPTIMIZATIONS
        if (row == 6) { self.navigationController?.show(ImageOptimizationVC(), sender: nil) }

        // (6) LAYER RASTERIZATION
        if (row == 7) { self.navigationController?.show(LayerRasterizationVC(), sender: nil) }

        // (7) NO OFFSCREEN RENDERING
        if (row == 8) { self.navigationController?.show(NoOffscreenRenderingVC(), sender: nil) }
    }

}


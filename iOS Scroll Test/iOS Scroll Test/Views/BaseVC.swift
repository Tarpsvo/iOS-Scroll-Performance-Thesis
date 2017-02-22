import UIKit
import SnapKit
import JASON

class BaseVC: UIViewController {

    internal var _tableView: UITableView!
    internal var _benchmarkButton: UIButton!
    internal var _messages: [Message]!
    private var _benchmarkRunning: Bool = false
    private var _scrollTimer: Timer?
    private var _benchmarkNeedsToStop: Bool = false
    private var _currentIndex: Int = 0
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        // set up tableview
        self._tableView = UITableView()
        self.view.addSubview(self._tableView)
        self._tableView.snp.makeConstraints { make -> Void in
            make.edges.equalTo(self.view)
        }
        self._tableView.backgroundColor = Pairby.Colors.GRAY_BG
        self._tableView.separatorStyle = .none
        
        // set up benchmarking button
        self._benchmarkButton = UIButton(type: .system)
        self.view.addSubview(self._benchmarkButton)
        self._benchmarkButton.snp.makeConstraints { make -> Void in
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(self.view).offset(-20)
        }
        self._benchmarkButton.setTitle("START BENCHMARK", for: .normal)
        self._benchmarkButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(benchmarkButtonTapped)))
        
        // load messages
        self._messages = MessageStore.messages
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func benchmarkButtonTapped() {
        return (self._benchmarkRunning) ? self.stopBenchmark() : self.startBenchmark()
    }
    
    func startBenchmark() {
        self._benchmarkButton.setTitle("STOP BENCHMARK", for: .normal)
        self._benchmarkRunning = true
        self._scrollTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(scrollTimerActivate), userInfo: nil, repeats: true)
    }
    
    func stopBenchmark() {
        self._benchmarkButton.setTitle("START BENCHMARK", for: .normal)
        self._benchmarkRunning = false
        self._scrollTimer?.invalidate()
        self._currentIndex = 0
        self._benchmarkNeedsToStop = false
    }
    
    func scrollTimerActivate() {
        // stop if we reached the end
        if (self._benchmarkNeedsToStop) { return stopBenchmark() }
        
        // calculate new data
        var contentOffset = self._tableView.contentOffset
        contentOffset.y = (contentOffset.y + 600 + (self._tableView.contentSize.height / 50))
        self._tableView.setContentOffset(contentOffset, animated: true)
        
        // calculate whether we need to stop
        let yPosition = (contentOffset.y + self._tableView.bounds.height - self._tableView.contentInset.bottom)
        if (yPosition >= self._tableView.contentSize.height) { self._benchmarkNeedsToStop = true }
    }

}

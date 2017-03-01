import UIKit
import SnapKit
import JASON
import FPSCounter

class BaseVC: UIViewController {

    internal var _tableView: UITableView!
    internal var _benchmarkButton: UIButton!
    internal var _messages: [Message]!
    private var _benchmarkRunning: Bool = false
    private var _scrollTimer: Timer?
    private var _benchmarkNeedsToStop: Bool = false
    private var _currentIndex: Int = 0
    private var _increment: CGFloat = 0
    private var _scrollToBottomCount: Int = 0
    private var _fpsCounter: FPSCounter?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        // set up fps counter
        self._fpsCounter = FPSCounter()
        self._fpsCounter?.notificationDelay = 0.5
        
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
        self._resetIncrement()
        self._benchmarkButton.setTitle("STOP BENCHMARK", for: .normal)
        self._benchmarkRunning = true
        self._fpsCounter?.startTracking()
        self._scrollTimer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(scrollTimerActivate), userInfo: nil, repeats: true)
    }
    
    func stopBenchmark() {
        self._benchmarkButton.setTitle("START BENCHMARK", for: .normal)
        self._benchmarkRunning = false
        self._fpsCounter?.stopTracking()
        self._scrollTimer?.invalidate()
        self._currentIndex = 0
        self._benchmarkNeedsToStop = false
        self._scrollToBottomCount = 0
    }
    
    func scrollTimerActivate() {
        // stop if we reached the end
        if (self._benchmarkNeedsToStop) { return stopBenchmark() }
        
        // calculate new data
        var contentOffset = self._tableView.contentOffset
        contentOffset.y = floor(contentOffset.y + 50 + self._increment)
        self._tableView.setContentOffset(contentOffset, animated: true)
        
        // calculate whether we need to stop
        let yPosition = (contentOffset.y + self._tableView.bounds.height - self._tableView.contentInset.bottom)
        if (yPosition >= self._tableView.contentSize.height) {
            if (self._scrollToBottomCount == 4) { self._benchmarkNeedsToStop = true }
            else {
                self._scrollToBottomCount += 1
                self._resetIncrement()
                self._tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            }
        }
        
        // increment
        self._increment += 30
    }
    
    func _resetIncrement() {
        self._increment = 100
    }

}

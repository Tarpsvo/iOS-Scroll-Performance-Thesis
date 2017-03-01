import UIKit
import AsyncDisplayKit
import JASON
import FPSCounter

final class AsyncDisplayKitVC: UIViewController, ASTableDataSource, ASTableDelegate {
    
    private var _tableNode: ASTableNode!
    private var _messages: [Message]!
    internal var _benchmarkButton: UIButton!
    private var _benchmarkRunning: Bool = false
    private var _scrollTimer: Timer?
    private var _benchmarkNeedsToStop: Bool = false
    private var _currentIndex: Int = 0
    private var _increment: CGFloat = 0
    private var _scrollToBottomCount: Int = 0
    private var _fpsCounter: FPSCounter?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.title = "AsyncDisplayKitVC"
        
        // set up fps counter
        self._fpsCounter = FPSCounter()
        self._fpsCounter?.notificationDelay = 0.5
        
        // set up tablenode
        self._tableNode = ASTableNode(style: .plain)
        self._tableNode.view.separatorStyle = .none
        self.view.backgroundColor = Pairby.Colors.GRAY_BG
        self._tableNode.delegate = self
        self._tableNode.dataSource = self
        self.view.addSubnode(self._tableNode)
        
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
    
    override func viewWillLayoutSubviews() {
        self._tableNode.frame = self.view.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("storyboards are incompatible with truth and beauty")
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return self._messages.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let message = self._messages[indexPath.row]
        return {
            let cell = ASTextCellNode()
            cell.text = (message.message != nil) ? message.message! : "Media message with ID [\(message.id)]"
            return cell
        }
    }
    
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
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
        var contentOffset = self._tableNode.view.contentOffset
        contentOffset.y = floor(contentOffset.y + 50 + self._increment)
        self._tableNode.view.setContentOffset(contentOffset, animated: true)
        
        // calculate whether we need to stop
        let yPosition = (contentOffset.y + self._tableNode.view.bounds.height - self._tableNode.view.contentInset.bottom)
        if (yPosition >= self._tableNode.view.contentSize.height) {
            if (self._scrollToBottomCount == 4) { self._benchmarkNeedsToStop = true }
            else {
                self._scrollToBottomCount += 1
                self._resetIncrement()
                self._tableNode.view.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            }
        }
        
        // increment
        self._increment += 30
    }
    
    func _resetIncrement() {
        self._increment = 100
    }
    
}

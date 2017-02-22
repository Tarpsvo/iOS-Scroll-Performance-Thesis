import UIKit
import AsyncDisplayKit
import JASON

final class AsyncDisplayKitVC: UIViewController, ASTableDataSource, ASTableDelegate {
    
    private var _tableNode: ASTableNode!
    private var _messages: [Message]!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.title = "AsyncDisplayKitVC"
        self._tableNode = ASTableNode(style: .plain)
        self._tableNode.view.separatorStyle = .none
        self.view.backgroundColor = Pairby.Colors.GRAY_BG
        self._tableNode.delegate = self
        self._tableNode.dataSource = self
        
        // load messages
        self._messages = MessageStore.messages
        
        self.view.addSubnode(self._tableNode)
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
    
}

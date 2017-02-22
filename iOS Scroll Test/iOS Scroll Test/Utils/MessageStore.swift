import UIKit
import JASON

class MessageStore {
    
    static var messages: [Message] = {
        if let path = Bundle.main.path(forResource: "MessagesJSON", ofType: "json") {
            let jsonData = try! NSData(contentsOfFile: path, options: .mappedIfSafe) as Data
            let json = JSON(jsonData)
            return json.map(Message.init)
        }
        return []
    }()
    
}

import UIKit
import JASON

struct Message {

    public var id: Int64
    public var direction: String
    public var message: String?
    public var mediaItems: [String]?
    
    init(_ json: JSON) {
        id = json["message_id"].nsNumberValue.int64Value
        direction = json["direction"].stringValue
        message = json["message"].string
        mediaItems = json["mediaItems"].array as? [String]
    }

}

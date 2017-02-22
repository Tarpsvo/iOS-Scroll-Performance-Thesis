import UIKit

struct Pairby {
    struct Colors {
        // -- BLUE GRAY
        static let BLUE_GRAY_LIGHT = UIColor(hexString: "#F5F6F7");
        static let BLUE_GRAY_50 = UIColor(hexString: "#ECEFF1")
        static let BLUE_GRAY_100 = UIColor(hexString: "#CFD8DC")
        static let BLUE_GRAY_200 = UIColor(hexString: "#B0BEC5")
        static let BLUE_GRAY_300 = UIColor(hexString: "#90A4AE")
        static let BLUE_GRAY_400 = UIColor(hexString: "#78909C")
        static let BLUE_GRAY_600 = UIColor(hexString: "#546E7A")
        static let BLUE_GRAY_700 = UIColor(hexString: "#455A64")
        static let BLUE_GRAY_900 = UIColor(hexString: "#263238")
        
        // -- OTHER
        static let BLUE_MEDIUM = UIColor(hexString: "#44729C")
        static let BLUE_LIGHT = UIColor(hexString: "#03A9F4")
        static let BLUE_DARK = UIColor(hexString: "#0C2340")
        static let ORANGE = UIColor(hexString: "#D84315")
        static let PINK = UIColor(hexString: "#AD1457")
        static let TEAL = UIColor(hexString: "#4DB6AC")
        static let GRAY_BG = UIColor(hexString: "#FAFAFA")
        static let GRAY_BG_DARKER = UIColor(hexString: "#F5F6F7")
    }
    
    struct MessageUI {
        // -- INNER
        static let MARGIN_VERTICAL: CGFloat = 8
        static let MARGIN_HORIZONTAL: CGFloat = 16
        
        // -- OUTER
        static let MARGIN_VERTICAL_WRAP: CGFloat = 5
        static let MARGIN_HORIZONTAL_WRAP_FIXED: CGFloat = 16
        static let MARGIN_HORIZONTAL_WRAP_DYNAMIC: CGFloat = 60
        
        // -- MEDIA ITEMS
        static let HEIGHT_MEDIA_ONE: CGFloat = 160
        static let HEIGHT_MEDIA_MULTIPLE: CGFloat = 80
        
        // -- UI
        static let TEXT_FONT = UIFont.systemFont(ofSize: 12)
    }
}

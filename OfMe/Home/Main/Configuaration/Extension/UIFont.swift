import Foundation
import UIKit

extension UIFont {
    
    public enum NotosType: String {
        case thin = "Thin"
        case regular = "Regular"
        case medium = "Medium"
        case black = "Black"
        case light = "Light"
        case bold = "Bold"
    }
    
    static func Notos(_ type: NotosType, size: CGFloat) -> UIFont {
        return UIFont(name: "NotoSansKR-\(type.rawValue)", size: size)!
    }
}

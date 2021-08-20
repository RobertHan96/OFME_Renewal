

import Foundation
import UIKit

extension UILabel {
    func makeHightledText(all text: String,for subText: String) {
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttributes([
            .font : UIFont.Notos(.bold, size: 18),
            .foregroundColor : UIColor.gray2
        ], range: (text as NSString).range(of: text))
        
        attributedText.addAttributes([
            .font : UIFont.Notos(.medium, size: 18),
            .foregroundColor : UIColor.mainBlue
        ], range: (text as NSString).range(of: subText))
        self.attributedText = attributedText
    }
    
    func makeHightledText(all text: String,for subText: String, font: UIFont) {
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttributes([
            .font : font,
            .foregroundColor : UIColor.gray2
        ], range: (text as NSString).range(of: text))
        
        attributedText.addAttributes([
            .font : font,
            .foregroundColor : UIColor.mainBlue
        ], range: (text as NSString).range(of: subText))
        self.attributedText = attributedText
    }
}

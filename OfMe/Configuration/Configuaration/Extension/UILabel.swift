

import Foundation
import UIKit

extension UILabel {
    func makeHightedBlueText(all text: String,for subText: String) {
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttributes([
            .font : UIFont.Notos(.bold, size: 18),
            .foregroundColor : UIColor.typoBlack
        ], range: (text as NSString).range(of: text))
        
        attributedText.addAttributes([
            .font : UIFont.Notos(.bold, size: 18),
            .foregroundColor : UIColor.mainBlue
        ], range: (text as NSString).range(of: subText))
        self.attributedText = attributedText
    }
    
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
            .foregroundColor : UIColor.mainBlue,
            .backgroundColor : UIColor.textHighlightColor
        ], range: (text as NSString).range(of: subText))
        self.attributedText = attributedText
    }
    
    func conceptResultmakeHightledText(all text: String,
                                       subText: String,
                                       totalText: String,
                                       highlightText: String,
                                       hitligthedFont: UIFont,
                                       normalFont: UIFont) {
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttributes([
            .font : normalFont,
            .foregroundColor : UIColor.typoBlack
        ], range: (text as NSString).range(of: text))
        
        attributedText.addAttributes([
            .font : hitligthedFont,
            .foregroundColor : UIColor.mainBlue,
            .backgroundColor : UIColor.textHighlightColor
        ], range: (text as NSString).range(of: highlightText))

        attributedText.addAttributes([
            .font : normalFont,
            .foregroundColor : UIColor.typoBlack,
            .backgroundColor : UIColor.textHighlightColor
        ], range: (text as NSString).range(of: totalText))

        self.attributedText = attributedText
    }
}

@IBDesignable class PaddingLabel: UILabel {

    @IBInspectable var topInset: CGFloat = 5.0
    @IBInspectable var bottomInset: CGFloat = 5.0
    @IBInspectable var leftInset: CGFloat = 8.0
    @IBInspectable var rightInset: CGFloat = 8.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
    let size = super.intrinsicContentSize
    return CGSize(width: size.width + leftInset + rightInset, height: size.height + topInset + bottomInset)
    }
}

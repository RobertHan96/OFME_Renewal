import UIKit
import SwiftUI

// MARK: UIButton 내에 Indicator 표시
extension UIButton {
    func showIndicator() {
        let indicator = UIActivityIndicatorView()
        let buttonHeight = self.bounds.size.height
        let buttonWidth = self.bounds.size.width
        indicator.center = CGPoint(x: buttonWidth / 2, y: buttonHeight / 2)
        self.addSubview(indicator)
        indicator.startAnimating()
    }
    
    func dismissIndicator() {
        for view in self.subviews {
            if let indicator = view as? UIActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
        }
    }
    
    func middleButtonShadow() {
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 10
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.3
    }
    
    
    func setCustomTitle(text: String, font: UIFont, color: UIColor) {
        self.setAttributedTitle(
            NSAttributedString(string: text,
                               attributes: [
                                .font : font,
                                .foregroundColor : color
                               ]), for: .normal)
    }
    
    func makeRoundedButtnon(_ title: String, titleColor: UIColor , borderColor: CGColor, backgroundColor: UIColor) {
        self.contentEdgeInsets = UIEdgeInsets(top: 11, left: 20, bottom: 15, right: 20)
        self.setTitleColor(titleColor, for: .normal)
        self.setTitle(title, for: .normal)
        self.layer.borderWidth = 1
        self.layer.borderColor = borderColor
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = self.frame.height / 2
    }

    func makeSmallRoundedButtnon(_ title: String, titleColor: UIColor , borderColor: CGColor, backgroundColor: UIColor) {
        self.contentEdgeInsets = UIEdgeInsets(top: 4, left: 22, bottom: 7, right: 22)
        self.setTitleColor(titleColor, for: .normal)
        self.setTitle(title, for: .normal)
        self.layer.borderWidth = 1
        self.layer.borderColor = borderColor
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = self.frame.height / 2
    }
    
    func makeRoundedTagButtnon(_ title: String, titleColor: UIColor , borderColor: CGColor, backgroundColor: UIColor) {
        self.contentEdgeInsets = UIEdgeInsets(top: 1, left: 10, bottom: 3, right: 10)
        self.setTitleColor(titleColor, for: .normal)
        self.setTitle(title, for: .normal)
        self.layer.borderWidth = 1
        self.layer.borderColor = borderColor
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = 4
    }
    
    func roundCorners(corners:UIRectCorner, radius: CGFloat)
    {
      let borderLayer = CAShapeLayer()
      borderLayer.frame = self.layer.bounds
//        borderLayer.strokeColor = GenerateShape.UIColorFromHex(0x989898,
//        alpha: (1.0-0.3)).CGColor
//        borderLayer.fillColor = UIColor.clear.cgColor
//      borderLayer.lineWidth = 1.0
      let path = UIBezierPath(roundedRect: self.bounds,
        byRoundingCorners: corners,
        cornerRadii: CGSize(width: radius, height: radius))
        borderLayer.path = path.cgPath
      self.layer.addSublayer(borderLayer);
    }
}

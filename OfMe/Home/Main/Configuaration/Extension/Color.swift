//
//  Color.swift
//  EduTemplate
//
//  Created by Zero Yoon on 2020/10/08.
//

import UIKit

extension UIColor {
    
    func as1ptImage() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        setFill()
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return image
    }
    // MARK: hex code를 이용하여 정의
    // ex. UIColor(hex: 0xF5663F)
    convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    // MARK: 메인 테마 색 또는 자주 쓰는 색을 정의
    // ex. label.textColor = .mainOrange
    class var gradientLeft: UIColor { UIColor(hex: 0x365CD8) }
    class var gradientRight: UIColor { UIColor(hex: 0x7379EA) }
    class var gray3: UIColor { UIColor(hex: 0x828282) }
    class var gray2: UIColor { UIColor(hex: 0x4F4F4F) }
    class var borderColor: UIColor { UIColor(hex: 0xEDEDED) }
    class var tabBarBlue: UIColor { UIColor(hex: 0x4761C6) }
    class var mainBlue: UIColor { UIColor(hex: 0x1038BC) }
    class var purple: UIColor { UIColor(hex: 0xF4F5FF) }
    class var mainBlueBlur: UIColor { UIColor(hex: 0x1038BC) }
    class var gray4: UIColor { UIColor(hex: 0xBDBDBD) }
    
}

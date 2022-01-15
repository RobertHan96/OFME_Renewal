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
    class var typoBlack: UIColor { UIColor(hex: 0xD2D2D) }

    // 메인 Cells에서 사용하는 색상들
    class var endCharacterBtnBackground: UIColor { UIColor(hex: 0xF9FAFC) }
    class var endCharacterBtnBorder: UIColor { UIColor(hex: 0xD9DFE7) }
    class var endCharacterBtnTitle: UIColor { UIColor(hex: 0x868E9E) }
    class var characterFeatureCellBackground: UIColor { UIColor(hex: 0xF4F5FF) }
    class var characterFeatureCellGrayBackground: UIColor { UIColor(hex: 0xFFFFFF) }
    class var favoriteSongArtistName: UIColor { UIColor(hex: 0x828282) }

    // 컨셉 종료 Cells에서 사용하는 색상들
    class var conceptResultCellBackground: UIColor { UIColor(hex: 0xFAFAFA)}
    class var ofMeColor: UIColor { UIColor(hex: 0x365CD8) }
    class var textHighlightColor: UIColor { UIColor(hex: 0xEDF0F8) }
    class var typoBlue: UIColor { UIColor(hex: 0x1038BC) }
    class var titleHilightText: UIColor { UIColor(hex: 0x9694F5) }
    class var characterFeatureCellBorder: UIColor { UIColor(hex: 0xF1F4F9) }

    
    // 팝업에서 쓰는 색상들
    class var popupSubTitleColor: UIColor { UIColor(hex: 0xEAEEFF) }

    // 로그인에서 쓰는 색상들
    class var nicknameTextFieldColor: UIColor { UIColor(hex: 0xF7F7F8) }
    class var nicknameDuplecatedWaringColor: UIColor { UIColor(hex: 0xF8522D) }
    
    // pageControll Indicator 색상
    class var currentPageIndicatorColor: UIColor { UIColor(hex: 0xC3CAD6) }
    class var otherPageIndicatorColor: UIColor { UIColor(hex: 0xE7EAEF) }

    // 홈 -> 캐릭터 액션 사이드 메뉴바에서 사용하는 색상
    class var actionImageBorderColor: UIColor { UIColor(hex: 0xE1E3E9) }
    
    // TabBar 관련
    class var tabBarIconColor: UIColor { UIColor(hex: 0xD8D8D8) }
    class var selectedTabBarIconColor: UIColor { UIColor(hex: 0x4761C6) }

    // 마이페이지
    class var totalConceptHistoryLabelColor: UIColor { UIColor(hex: 0x818182) }
    class var profileDetailButtonBackgroundColor: UIColor { UIColor(hex: 0x6181E8) }
    class var welcomTextColor: UIColor { UIColor(hex: 0x8195CE) }
}

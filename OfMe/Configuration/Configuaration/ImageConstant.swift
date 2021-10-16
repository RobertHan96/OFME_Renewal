import Foundation

struct ImgName {
    
    private init() {}
    
    enum imgNameType: String {
        case loginLogo = "loginLogo"
        case chevronLeft = "chevron_left"
        case checked = "checked"
        case unchecked = "unchecked"
        case falseCheck = "falseCheck"
        case trueCheck = "trueCheck"
        case homeIcon = "home"
        case questionIcon = "question"
        case myInfoIcon = "myInfo"
        case archiveIcon = "archive"
        case cancel = "cancel"
        case chevronRightWhite = "chevron_right_white"
        case chevronRightMainBlue = "chevron_right_mainBlue"
        case bubble = "bubble"
        case testIcon = "test_icon"
        case normalIcon = "normalIcon"
        case moon = "moon"
        case play = "play"
        case pause = "pause"
        case info = "info"
        case defaultImg = "default"
        case backgroundStop = "homeBackground_1"
        case defaultStop = "default_stop_1"
        case background = "homeBackground"
        case bubbleRight = "bubble_right"
        case bottle = "bottle"
        case sun = "sun"
        case bed = "bed"
        case hand = "hand"
        case reset = "reset"
        case tv = "tv"
        case defaultWater = "default_water"
        case defaultWater1 = "default_water_1"
        case defaultTV = "default_tv"
        case defaultTV1 = "default_tv_1"
        case defaultSun = "default_sun"
        case defaultSun1 = "default_sun_1"
        case defaultSleep = "default_sleep"
        case defaultSleep1 = "default_sleep_1"
        case defaultHand = "default_hand"
        case defaultHand1 = "default_hand_1"
        case backgroundSun = "homeBackground_2"
        case sunButton = "sun_button"
        case triangleDown = "triangle_down"
        case write = "write"
        case image = "image"
        case cancelRound = "cancel_round"
        case starFill = "star_fill"
        case starNonFill = "star_non_fill"
        case lock = "lock"
        case unlock = "unlock"
        case defaultProfile = "profile"
        case mask = "mask"
        case starFillSmall = "star_fill_small"
        case starSmall = "star_small"
        case sendBackground = "send_background"
    }
    
    static func imgName(of imgType: imgNameType) -> String {
        return imgType.rawValue
    }
}

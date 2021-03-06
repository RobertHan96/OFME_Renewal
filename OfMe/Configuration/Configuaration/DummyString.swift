import Foundation

struct DummyData {
    static let finishEndData = FinishEnd(clientTime: 0, url: "https://ofmebucket.s3.ap-northeast-2.amazonaws.com/01_default_1.png", conceptId: 1)
    static let pretestString = "나만 믿고 따라와!"
    static let titleResultString = "안 되는 거 빼고 다 되는\n현실주의자"
    static let titleResultHLString = "현실주의자"
    static let keywordString = "꼼꼼한, 책임감있는, 완벽한"
    static let aboutString = "꼼꼼하고 책임감이 강한 성격의 소유자인 당신은\n맡은 일이 있으면 누구보다 완벽하게 끝내는 편이에요!\n때로는 흥미로운 일을 제외하고 공감을 잘 못하지만\n꾸준함의 매력으로 사람들에게 신뢰를 얻습니다."
    static let conceptTitleString = "알고보니 나만 웃고  있는 상황..\n이후 내가 할 행동은?"
    static let conceptTitleHLString = "내가 할 행동"
    
    
    static let descriptSheet: [String] = [
        "친구와의 저녁 약속,\n저녁 메뉴 고를 때 나는 ?",
        "내가 받고싶은,\n서프라이즈 선물은 ?",
        "운동을 끝낸 후,\n거울을 보며 드는 생각은?",
        "오랜만에 연락 온,\n동창 모임이 생긴 나는 ?",
        "친구와의 저녁 약속,\n저녁 메뉴 고를 때 나는 ?",
        "내가 받고싶은,\n서프라이즈 선물은 ?",
        "운동을 끝낸 후,\n거울을 보며 드는 생각은?",
        "오랜만에 연락 온,\n동창 모임이 생긴 나는 ?",
        "친구와의 저녁 약속,\n저녁 메뉴 고를 때 나는 ?",
        "내가 받고싶은,\n서프라이즈 선물은 ?",
        "운동을 끝낸 후,\n거울을 보며 드는 생각은?",
        "오랜만에 연락 온,\n동창 모임이 생긴 나는 ?",
    ]
    static let answerSheet1: [String] = [
        "내가 먹고 싶은 걸로",
        "진심을 가득 담은 로맨틱한 꽃과 편지",
        "‘오늘 1시간이나 했네’ 생각하며 빨리 씻으러간다",
        "동창 관계 중요- 당연히 가야지!",
        "내가 먹고 싶은 걸로",
        "진심을 가득 담은 로맨틱한 꽃과 편지",
        "‘오늘 1시간이나 했네’ 생각하며 빨리 씻으러간다",
        "동창 관계 중요- 당연히 가야지!",
        "내가 먹고 싶은 걸로",
        "진심을 가득 담은 로맨틱한 꽃과 편지",
        "‘오늘 1시간이나 했네’ 생각하며 빨리 씻으러간다",
        "동창 관계 중요- 당연히 가야지!",
    ]
    
    static let answerSheet2: [String] = [
        "그냥 친구 의견 따름",
        "나에게 꼭 필요했던 실용적인 선물",
        "내가 바로 근수저? 벌써 복근 생긴 느낌적인 느낌",
        "내일 해야 할 일에 지장이 있다면 안 감",
        "그냥 친구 의견 따름",
        "나에게 꼭 필요했던 실용적인 선물",
        "내가 바로 근수저? 벌써 복근 생긴 느낌적인 느낌",
        "내일 해야 할 일에 지장이 있다면 안 감",
        "그냥 친구 의견 따름",
        "나에게 꼭 필요했던 실용적인 선물",
        "내가 바로 근수저? 벌써 복근 생긴 느낌적인 느낌",
        "내일 해야 할 일에 지장이 있다면 안 감",
    ]
    
    static let highlightedSheet: [String] = [
        "저녁 메뉴 고를 때",
        "서프라이즈 선물",
        "거울을 보며 드는 생각",
        "동창 모임이 생긴 나",
        "저녁 메뉴 고를 때",
        "서프라이즈 선물",
        "거울을 보며 드는 생각",
        "동창 모임이 생긴 나",
        "저녁 메뉴 고를 때",
        "서프라이즈 선물",
        "거울을 보며 드는 생각",
        "동창 모임이 생긴 나"
    ]
    
    static let character: [String] = [
        "",
        "모스",
        "제이비",
        "리아",
        "이노",
        "시애나",
        "헤더",
        "로하",
        "로키",
        "폴",
        "주주",
        "옐로우",
        "마크",
        "뮤즈",
        "빈",
        "하이",
        "피즈",
        "베어",
        "크리스탈",
        "오앤",
        "유우"
    ]
}

struct Strings {
    // 얼럿에 필요한 텍스트
    static let alertTitleText = "우리 내일 다시 만나요!"
    static let PatchConceptRatingFaildAlert = "별점을 입력해주세요 :)"
    static let PatchFinishEndDataFaildAlert = "진행 중인 컨셉이 없습니다."
    static let networkConectionFaildTitleAlert = "앗... 데이터를 불러오지 못했어요!"
    static let networkConectionFaildSubAlert = "네트워크 연결 상태를 확인해주세요."
    static let dailyTestLimitOverAlert = "앗! 컨셉 테스트는 한 번만 가능합니다.\n다음에 다시 시도해 주세요."
    static let conceptRatingLaterAlert = "컨셉을 종료하기 위해 만족한 만큼\n별점을 표시해주세요."
    static let conceptLimitOverAlert = "이미 진행 중인 컨셉이 있습니다."
    
    // userDefault 관련 값
    static let userDefaultStageOneResult = "stageOneResult"
    static let userDefaultStageTwoResult = "stageTwoResult"
    static let userDefaultDeviceJwtToken = "jwt"
}

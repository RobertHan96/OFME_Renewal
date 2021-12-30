import Foundation
import RxRelay

// rx로 받아서 viewController로 바인딩해주는 로직 구현 필요
class MakeNicknameViewModel {
    var nickname = ""
    let service = MakeNicknameAPIService()
    let nicknameMakingResult = BehaviorRelay(value: "")
    let infromMessage = BehaviorRelay<NSAttributedString>(value: NSAttributedString(string: ""))
    let isDuplecatedNickname = BehaviorRelay<Bool>(value: true)
    
    private func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일 HH시 mm분"
        return formatter.string(from: date)
    }
    
    func makeNickname(nickname: String) {
        // API 관련 내용 APIService로 이동
        self.service.postUserNickname(nickname: nickname) { [weak self] makeNicknameResponse in
            if makeNicknameResponse.code == 1000 {
                guard let self = self else {return}
                let makeNicknameSucuess = "1000"
                self.nicknameMakingResult.accept(makeNicknameSucuess)
            } else {
                guard let self = self else {return}
                let makeNicknameFailed = "\(makeNicknameResponse.code)"
                self.nicknameMakingResult.accept(makeNicknameFailed)
                print("LOG:", makeNicknameResponse)
            }
        }
    }
    
    func checkDuplecatedNickname() {
        // UI 관련 내용은 ViewController 이동 -> 텍스트값만 반환해줌
        self.service.postCheckUserNicknameDuplecated(nickname: nickname) { [weak self] result in
            if let successResult = try? result.get() {
                if successResult.code == 1000 {
                    guard let self = self else {return}
                    let attributedString = NSMutableAttributedString(string: "")
                    let text = " 사용 가능한 닉네임입니다."
                    let attachedImage = NSTextAttachment()
                    attachedImage.image = UIImage(named: "trueCheck")
                    attributedString.append(NSAttributedString(attachment: attachedImage))
                    attributedString.append(NSAttributedString(string: text))
                    self.infromMessage.accept(attributedString)
                    self.isDuplecatedNickname.accept(false)
                }
            } else {
                guard let self = self else {return}
                let attributedString = NSMutableAttributedString(string: "")
                let text = " 이미 사용 중인 닉네임입니다."
                let attachedImage = NSTextAttachment()
                attachedImage.image = UIImage(named: "falseCheck")
                attributedString.append(NSAttributedString(attachment: attachedImage))
                attributedString.append(NSAttributedString(string: text))
                self.infromMessage.accept(attributedString)
                self.isDuplecatedNickname.accept(true)
            }
        }
    }
    
    func checkNicknamePolicy() -> Bool {
        if checkTextLength() && checkKoreanName() {
            return true
        }
        
        return false
    }
    
    private func checkTextLength() -> Bool {
        if nickname.count < 2 || nickname.count > 10 {
            return false
        }
        
        return true
    }
    
    private func checkKoreanName() -> Bool {
        // String -> Array
        let arr = Array(nickname)
        // 정규식 pattern. 한글, 영어, 숫자, 밑줄(_)만 있어야함
        let pattern = "^[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]$"
        if let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) {
            var index = 0
            while index < arr.count { // string 내 각 문자 하나하나 마다 정규식 체크 후 충족하지 못한것은 제거.
                let results = regex.matches(in: String(arr[index]), options: [], range: NSRange(location: 0, length: 1))
                if results.count == 0 {
                    return false
                } else {
                    index += 1
                }
            }
        }
        
        if nickname.count < 2 || nickname.count > 10 {
            return false
        }
        return true
    }
    
}

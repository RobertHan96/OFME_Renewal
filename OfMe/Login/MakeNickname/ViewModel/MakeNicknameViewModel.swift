import Foundation
import RxRelay

// rx로 받아서 viewController로 바인딩해주는 로직 구현 필요
class ViewModel {
    var nickname = ""

    let service = MakeNicknameAPIService()

    private func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일 HH시 mm분"
        return formatter.string(from: date)
    }
    
    func reload() {
        self.service.postCheckUserNicknameDuplecated(nickname: nickname) { result in
            if let successResult = try? result.get() {
                if successResult.code == 1000 {
                    let attributedString = NSMutableAttributedString(string: "")
                    let text = " 사용 가능한 닉네임입니다."
                    let attachedImage = NSTextAttachment()
                    attachedImage.image = UIImage(named: "trueCheck")
                    attributedString.append(NSAttributedString(attachment: attachedImage))
                    attributedString.append(NSAttributedString(string: text))
//                    self.nicknameStatusLabel.attributedText = attributedString
//                    self.nextButton.isEnabled = true
//                    self.nextButton.backgroundColor = .typoBlue
//                    self.nicknameStatusLabel.isHidden = false
//                    self.nicknameStatusLabel.textColor = .typoBlue
                }
            } else {
                let attributedString = NSMutableAttributedString(string: "")
                let text = " 이미 사용 중인 닉네임입니다."
                let attachedImage = NSTextAttachment()
                attachedImage.image = UIImage(named: "falseCheck")
                attributedString.append(NSAttributedString(attachment: attachedImage))
                attributedString.append(NSAttributedString(string: text))
//                self.nicknameStatusLabel.attributedText = attributedString
//                self.nicknameStatusLabel.isHidden = false
//                self.nicknameStatusLabel.textColor = .nicknameDuplecatedWaringColor
            }
        }
    }
}

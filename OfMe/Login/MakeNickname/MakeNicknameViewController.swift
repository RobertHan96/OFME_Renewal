import UIKit
import RxCocoa
import RxSwift
import Alamofire

class MakeNicknameViewController: BaseViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nicknameTextFeild: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var clearTextButton: UIButton!
    @IBOutlet weak var checkDuplecatedNicknameButton: UIButton!
    @IBOutlet weak var nicknameStatusLabel: UILabel!
    let enabledBtnBackgroundImage = UIImage(named: "next_btn_background-1")
    let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func setupUI() {
        self.navigationItem.setHidesBackButton(true, animated: false)
        // 조건 만족시 다음 버튼 isEnabled = True로 변경 필요
        nicknameStatusLabel.isHidden = true
        nextButton.isEnabled = false
        clearTextButton.isHidden = true
        checkDuplecatedNicknameButton.isHidden = true
        nextButton.backgroundColor = .nicknameTextFieldColor
        checkDuplecatedNicknameButton.titleLabel?.textColor = .typoBlue
        nicknameStatusLabel.textAlignment = .center
    }
    
    private func bindUI() {
        nicknameTextFeild.rx.text.orEmpty
            .map { self.checkNicknamePolicy(text: $0) }
            .map { self.setNicknameDuplatedTestUI(isValidNickname: $0) }
            .subscribe { str in
                print(str)
            } onError: { err in
                print(err)
            }.disposed(by: disposeBag)
    }
    
    private func setNicknameDuplatedTestUI(isValidNickname: Bool) {
        if isValidNickname {
            self.checkDuplecatedNicknameButton.isHidden = false
            self.clearTextButton.isHidden = false
        } else {
            self.checkDuplecatedNicknameButton.isHidden = true
            self.clearTextButton.isHidden = true
        }
    }
    
    private func checkNicknamePolicy(text:String) -> Bool {
        if checkTextLength(text: text) && checkKoreanName(text: text) {
            return true
        }
        
        return false
    }
    
    private func checkTextLength(text: String) -> Bool {
        if text.count < 2 || text.count > 10 {
            return false
        }
        
        return true
    }
    
    private func checkKoreanName(text: String) -> Bool {
        // String -> Array
        let arr = Array(text)
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
        
        if text.count < 2 || text.count > 10 {
            return false
        }
        
        return true
    }

    private func fetchData() {
        // 닉네임 생성 가능할 때 활성화할 이미지
    }
    
    @IBAction func checkDuplecatedNicknameButtonDidClicked(_ sender: UIButton) {
        NicknameDataManager().postCheckUserNicknameDuplecated(nickname: nicknameTextFeild.text ?? "") { result in
            if let successResult = try? result.get() {
                if successResult.code == 1000 {
                    let attributedString = NSMutableAttributedString(string: "")
                    let text = " 사용 가능한 닉네임입니다."
                    let attachedImage = NSTextAttachment()
                    attachedImage.image = UIImage(named: "trueCheck")
                    attributedString.append(NSAttributedString(attachment: attachedImage))
                    attributedString.append(NSAttributedString(string: text))
                    self.nicknameStatusLabel.attributedText = attributedString
                    self.nextButton.isEnabled = true
                    self.nextButton.backgroundColor = .typoBlue
                    self.nicknameStatusLabel.isHidden = false
                    self.nicknameStatusLabel.textColor = .typoBlue
                }
            } else {
                let attributedString = NSMutableAttributedString(string: "")
                let text = " 이미 사용 중인 닉네임입니다."
                let attachedImage = NSTextAttachment()
                attachedImage.image = UIImage(named: "falseCheck")
                attributedString.append(NSAttributedString(attachment: attachedImage))
                attributedString.append(NSAttributedString(string: text))
                self.nicknameStatusLabel.attributedText = attributedString
                self.nicknameStatusLabel.isHidden = false
                self.nicknameStatusLabel.textColor = .nicknameDuplecatedWaringColor
            }
        }
    }
    
    @IBAction func clearTextButtonDidClicked(_ sender: UIButton) {
        nicknameTextFeild.text = nil
        nicknameStatusLabel.isHidden = true
    }
    
    @IBAction func nextButtonDidkClicked(_ sender: UIButton) {
        NicknameDataManager().postUserNickname(nickname: nicknameTextFeild.text ?? "") { makeNicknameResponse in
            if makeNicknameResponse.code == 1000 {
                self.changeRootViewController(BaseTabBarController().initMainTabBar())
            } else {
                self.presentBottomAlert(message: "닉네임 생성 실패 - code(\(makeNicknameResponse.code))")
                print("LOG:", makeNicknameResponse)
            }
        }
    }
}

import UIKit

class SignInViewController: LoginBaseViewController {
    private var info: SignInfo = SignInfo()
    private var dataManager: SignInDataManager = SignInDataManager()
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordCheckTextField: UITextField!
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var emailWarningLabel: UILabel!
    @IBOutlet weak var passwordWarningLabel: UILabel!
    @IBOutlet weak var nicknameWarningLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var agreeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let touch = UITapGestureRecognizer(target: self, action: #selector(singleTapGestureCaptured(gesture:)))
        scrollView.addGestureRecognizer(touch)
        setUP()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.scrollView.endEditing(true)
        setTextField()
    }
    
    @IBAction func signInTouchDown(_ sender: Any) {
        startRotating()
        if !info.check {
            self.presentAlert(title: "약관에 동의하여 주시기 바랍니다.")
        } else {
            if info.passwordCheck {
                dataManager.postSignRequest(vc: self, info: info) { result in
                    self.endRotating()
                    self.setResult(result: result)
                }
            } else {
                passwordWarningLabel.text = "비밀번호가 일치하지 않습니다."
            }
        }
        endRotating()
    }
    
    @IBAction func agreeTouchDown(_ sender: Any) {
        if !info.check {
            agreeButton.setImage(UIImage(named: ImgName.imgName(of: .checked)), for: .normal)
        } else {
            agreeButton.setImage(UIImage(named: ImgName.imgName(of: .unchecked)), for: .normal)
        }
        info.check = !info.check
    }
    
    func setResult(result: SignInResponse) {
        switch result.code {
        case 1000:
            self.navigationController?.popViewController(animated: true)
        default:
            [emailTextField, passwordTextField, passwordCheckTextField, nickNameTextField].forEach {
                $0?.addRightTrue()
            }
            [nicknameWarningLabel, passwordWarningLabel, emailWarningLabel].forEach {
                $0.text = ""
            }
            switch dataManager.resultTag[result.code] {
            case 0:
                emailWarningLabel.text = dataManager.resultText[result.code]
            case 1:
                passwordWarningLabel.text = dataManager.resultText[result.code]
            default:
                nicknameWarningLabel.text = dataManager.resultText[result.code]
            }
            
            switch dataManager.textFieldTag[result.code]{
            case 0:
                emailTextField.addRightFalse()
            case 1:
                passwordTextField.addRightFalse()
            case 2:
                passwordCheckTextField.addRightFalse()
            default:
                nickNameTextField.addRightFalse()
            }
        }
    }
    
    func setUP() {
        self.navigationItem.title = "회원가입"
        [emailWarningLabel, passwordWarningLabel, nicknameWarningLabel].forEach {
            $0?.font = .Notos(.regular, size: 11)
        }
        [emailTextField, passwordTextField, passwordCheckTextField, nickNameTextField].forEach {
            $0?.rightViewMode = .always
            $0?.addLeftPadding()
            $0?.font = .Notos(.regular, size: 14)
            $0?.delegate = self
        }
        submitButton.setGradient(color1: .gradientLeft, color2: .gradientRight)
    }
    
    func setTextField() {
        [emailTextField, passwordTextField, passwordCheckTextField, nickNameTextField].forEach {
            $0?.borderColor = .lightGray
        }
        if !info.passwordCheck {
            passwordCheckTextField.borderColor = .red
        }
    }
    
    @objc func singleTapGestureCaptured(gesture: UITapGestureRecognizer){
        self.view.endEditing(true)
        setTextField()
    }
}

extension SignInViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        switch textField.tag {
        case 0:
            textField.borderColor = .mainBlue
            if let text = textField.text {
                let email = text.trimmingCharacters(in: .whitespacesAndNewlines)
                info.email = email
            }
            setDefaultTextField(tag: 0)
        case 1:
            textField.borderColor = .mainBlue
            if let text = textField.text {
                let password = text.trimmingCharacters(in: .whitespacesAndNewlines)
                info.password = password
            }
            setDefaultTextField(tag: 1)
        case 2:
            textField.borderColor = .mainBlue
            if let text = textField.text {
                let passwordCheck = text.trimmingCharacters(in: .whitespacesAndNewlines)
                info.password2 = passwordCheck
                print("\(info.password) \(info.password2)")
                if info.password != info.password2 { info.passwordCheck = false } else { info.passwordCheck = true }
            }
            setDefaultTextField(tag: 2)
        default:
            textField.borderColor = .mainBlue
            if let text = textField.text {
                let nickname = text.trimmingCharacters(in: .whitespacesAndNewlines)
                info.nickName = nickname
            }
            setDefaultTextField(tag: 3)
        }
    }
    
    func setDefaultTextField(tag: Int) {
        [emailTextField, passwordTextField, passwordCheckTextField, nickNameTextField].forEach {
            if $0?.tag != tag {
                $0?.borderColor = .lightGray
            }
        }
        if !info.passwordCheck {
            passwordWarningLabel.text = "비밀번호가 일치하지 않습니다."
            passwordCheckTextField.borderColor = .red
            passwordCheckTextField.rightView = addRightFalse()
        } else {
            passwordWarningLabel.text = ""
            passwordCheckTextField.rightView = nil
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {return false}
        
        var maxLength: Int = 0
        switch textField.tag {
        case 0:
            maxLength = 50
        case 3:
            maxLength = 10
        default:
            maxLength = 20
        }
        
        if text.count >= maxLength && range.length == 0 && range.location < maxLength {
            return false
        }
        
        return true
    }
    
    func addRightFalse() -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 55))
        let imageView = UIImageView(image: UIImage(named: ImgName.imgName(of: .falseCheck)))
        imageView.frame = CGRect(x: 0, y: 25, width: imageView.frame.width, height: imageView.frame.height)
        view.addSubview(imageView)
        return view
    }
    
    func addRightTrue() -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 55))
        let imageView = UIImageView(image: UIImage(named: ImgName.imgName(of: .trueCheck)))
        imageView.frame = CGRect(x: 0, y: 25, width: imageView.frame.width, height: imageView.frame.height)
        view.addSubview(imageView)
        return view
    }
}

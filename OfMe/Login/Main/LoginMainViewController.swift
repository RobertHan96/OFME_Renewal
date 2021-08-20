import UIKit

class LoginMainViewController: LoginBaseViewController {
    
    private let signinText = "아직 회원이 아니라면, 회원가입하기"
    private let signinFrontText = "아직 회원이 아니라면,"
    private let signinBackText = "회원가입하기"
    private let submitBtnText = "로그인"
    private var email = ""
    private var password = ""
    private let dataManager: LoginDataManager = LoginDataManager()

    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var signButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        idTextField.tag = 0
        passwordTextField.tag = 1
        setUP()
        [idTextField,passwordTextField].forEach {
            $0?.delegate = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func loginButtonTouchDown(_ sender: Any) {
//        self.changeRootViewController(CustomTabBarViewController())
        startRotating()
        dataManager.postLogin(vc: self, email: email, password: password) { result in
            self.endRotating()
            self.setResult(result: result)
        }
    }
    
    @IBAction func signinButtonTouchDown(_ sender: Any) {
        let vc = SignInViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setUP() {
        [idTextField,passwordTextField].forEach {
            $0?.addLeftPadding()
            $0?.font = .Notos(.regular, size: 14)
        }
        
        submitButton.cornerRadius = 6
        submitButton.backgroundColor = .mainBlue
        submitButton.setAttributedTitle(NSAttributedString(string: submitBtnText, attributes: [
            .font : UIFont.Notos(.bold, size: 17),
            .foregroundColor : UIColor.white
        ]), for: .normal)
        
        let attributedText = NSMutableAttributedString(string: signinText)
        
        attributedText.addAttributes([
            .font : UIFont.Notos(.regular, size: 13),
            .foregroundColor : UIColor.gray3
        ], range: (signinText as NSString).range(of: signinFrontText))
        
        attributedText.addAttributes([
            .font : UIFont.Notos(.medium, size: 13),
            .foregroundColor : UIColor.gray2
        ], range: (signinText as NSString).range(of: signinBackText))
        attributedText.addAttribute(.underlineStyle, value: NSUnderlineStyle.thick.rawValue,
                                    range: (signinText as NSString).range(of: signinBackText))
        attributedText.addAttribute(.underlineColor, value: UIColor.borderColor,
                                    range: (signinText as NSString).range(of: signinBackText))
        signButton.setAttributedTitle(attributedText, for: .normal)
    }
    
    func setResult(result: LoginResponse) {
        switch result.code {
        case 1000:
            if let info = result.result {
                UserDefaults.standard.setValue(info.jwt, forKey: "jwt")
                UserDefaults.standard.setValue(info.userId, forKey: "userID")
                self.changeRootViewController(CustomTabBarViewController())
            }
        default:
            if let text = dataManager.errorText[result.code] {
                self.presentAlert(title: text)
            } else {
                self.presentAlert(title: "다시 시도해주시기 바랍니다.")
            }
        }
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        if let keyboardFrame : NSValue = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            self.view.frame.origin.y = Device.bottomInset + Device.tabBarHeight - keyboardRectangle.height + 60
        }
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0
    }

}

extension LoginMainViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.tag == 0 {
            idTextField.borderColor = .mainBlue
            passwordTextField.borderColor = .lightGray
            if let text = textField.text {
                email = text.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        } else {
            passwordTextField.borderColor = .mainBlue
            idTextField.borderColor = .lightGray
            if let text = textField.text {
                password = text.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {return false}
        
        var maxLength: Int = 0
        if textField.tag == 0 {
            maxLength = 30
        } else {
            maxLength = 20
        }
        
        if text.count >= maxLength && range.length == 0 && range.location < maxLength {
            return false
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.endEditing(true)
        return true
    }
}

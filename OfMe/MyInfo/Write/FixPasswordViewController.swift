import UIKit

class FixPasswordViewController: BaseViewController {
    private let dataManager = InfoWriteDataManager()

    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var newpwTextField: UITextField!
    @IBOutlet weak var newpwcTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "비밀번호 변경"
        [pwTextField, newpwTextField, newpwcTextField].forEach {
            $0?.font = .Notos(.regular, size:14)
            $0?.delegate = self
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        middleButton = self.tabBarController?.normalMiddleButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        middleButton?.removeFromSuperview()
    }

    @IBAction func changeTouchDown(_ sender: Any) {
        if let origin = pwTextField.text, let new = newpwTextField.text, let new2 = newpwcTextField.text {
            dataManager.changePassword(origin: origin.trimmingCharacters(in: .whitespacesAndNewlines),
                                       new: new.trimmingCharacters(in: .whitespacesAndNewlines),
                                       new2: new2.trimmingCharacters(in: .whitespacesAndNewlines)) { code in
                switch code {
                case 3007:
                    self.presentAlert(title: "비밀번호가 일치하지 않습니다.")
                case 2004:
                    self.presentAlert(title: "비밀번호를 입력 해주세요.")
                case 2019:
                    self.presentAlert(title: "재확인 비밀번호를 입력해주세요.")
                case 3005:
                    self.presentAlert(title: "탈퇴 된 계정입니다.")
                case 3011:
                    self.presentAlert(title: "입력하신 이전 비밀번호가 틀립니다.")
                default:
                    self.presentAlert(title: "변경에 성공하셨습니다.", with: UIAlertAction(title: "돌아가기", style: .default, handler: { _ in
                        self.navigationController?.popViewController(animated: true)
                    }))
                }
                
            }
        }
    }
    
}

extension FixPasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newLength = (textField.text?.count)! + string.count - range.length
        return !(newLength > 20)
    }
}

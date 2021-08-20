import UIKit

class FixNameViewController: BaseViewController {
    private let dataManager = InfoWriteDataManager()

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "닉네임 변경"
        
        textField.font = .Notos(.regular, size:14)
        textField.delegate = self
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
        if let text = textField.text {
            dataManager.changeName(text: text.trimmingCharacters(in: .whitespacesAndNewlines)) { code in
                if code == 1000 {
                    self.navigationController?.popViewController(animated: true)
                } else if code == 2006 {
                    self.presentAlert(title: "내용을 입력해 주세요.")
                } else if code == 2007 {
                    self.presentAlert(title: "닉네임은 2~10자리를 입력해주세요.")
                } else if code == 2020 {
                    self.presentAlert(title: "닉네임은 한글만 허용됩니다.")
                }
            }
        }
    }
    
}

extension FixNameViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newLength = (textField.text?.count)! + string.count - range.length
        return !(newLength > 10)
    }
}

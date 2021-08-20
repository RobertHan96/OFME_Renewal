import UIKit

class DeleteUserViewController: BaseViewController {
    let dataManager = InfoDetailDataManager()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "회원탈퇴"
    }
    
    @IBAction func deleteTouchDown(_ sender: Any) {
        dataManager.delete() {
            if $0 == 1000 {
                UserDefaults.standard.removeObject(forKey: "jwt")
                UserDefaults.standard.removeObject(forKey: "userID")
                let root = UINavigationController(rootViewController: LoginMainViewController())
                self.changeRootViewController(root)
            }
        }
    }
    
    @IBAction func next(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

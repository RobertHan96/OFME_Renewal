import UIKit

class BaseViewController: UIViewController {
    internal weak var middleButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    func setUI() {
        self.navigationController?.navigationBar.barTintColor = .systemBackground
        setBackButton()
        setNavTitle()
    }
    
    func setNavTitle() {
        self.navigationController?.navigationBar.titleTextAttributes = [
            .font : UIFont.Notos(.bold, size: 14),
            .foregroundColor : UIColor.label
        ]
    }
    
    func setBackButton() {
        let backImage = UIImage(named: ImgName.imgName(of: .chevronLeft))
        self.navigationController?.navigationBar.backIndicatorImage = backImage?.withRenderingMode(.alwaysOriginal)
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage =
            backImage?.withRenderingMode(.alwaysOriginal)
        let backButton = UIBarButtonItem()
        backButton.title = " "
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

}

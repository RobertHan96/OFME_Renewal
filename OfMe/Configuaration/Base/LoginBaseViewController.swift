import UIKit
import NVActivityIndicatorView

class LoginBaseViewController: UIViewController {
    public let indicator = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50),
                                            type: .circleStrokeSpin,
                                            color: .black,
                                            padding: 0)
    
    public let backgroundView: UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backgroundView.frame = UIScreen.main.bounds
        self.backgroundView.backgroundColor = UIColor(white: 0, alpha: 0.4)
        
        self.indicator.frame = CGRect(x: UIScreen.main.bounds.width/2-25, y: UIScreen.main.bounds.height/2-25, width: 50, height: 50)
        self.view.addSubview(indicator)
        
        setUI()
    }
    
    func startRotating() {
        self.view.isUserInteractionEnabled = false
        self.view.addSubview(backgroundView)
        self.indicator.startAnimating()
    }
    
    func endRotating() {
        self.view.isUserInteractionEnabled = true
        backgroundView.removeFromSuperview()
        self.indicator.stopAnimating()
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

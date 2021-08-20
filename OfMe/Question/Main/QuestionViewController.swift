import UIKit

class QuestionViewController: BaseViewController {
    private var idx: Int = 0
    private let mainVC = QuestionMainViewController()
    private let subVC = QuestionSubMainViewController()

    @IBOutlet weak var subButton: UIButton!
    @IBOutlet weak var allButton: UIButton!
    @IBOutlet weak var allBorderView: UIView!
    @IBOutlet weak var subBorderView: UIView!
    @IBOutlet weak var subView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Q&A"
        middleButton = self.tabBarController?.normalMiddleButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        middleButton?.removeFromSuperview()
    }
    
    @IBAction func allTouchDown(_ sender: Any) {
        idx = 0
        setButton()
    }
    
    @IBAction func subTouchDown(_ sender: Any) {
        idx = 1
        setButton()
    }
    
    func setButton() {
        if idx == 1 {
            allButton.setAttributedTitle(NSAttributedString(string: "전체보기", attributes: [
                .font : UIFont.Notos(.regular, size: 14),
                .foregroundColor : UIColor.lightGray
            ]), for: .normal)
            allBorderView.backgroundColor = .systemBackground
            subButton.setAttributedTitle(NSAttributedString(string: "둘러보기", attributes: [
                .font : UIFont.Notos(.bold, size: 14),
                .foregroundColor : UIColor.mainBlue
            ]), for: .normal)
            subBorderView.backgroundColor = .mainBlue
            allButton.isUserInteractionEnabled = true
            subButton.isUserInteractionEnabled = false
            mainVC.view.removeFromSuperview()
            mainVC.removeFromParent()
            self.subView.addSubview(subVC.view)
            subVC.view.snp.makeConstraints { make in
                make.top.left.right.bottom.equalToSuperview()
            }
            self.addChild(subVC)
            subVC.didMove(toParent: self)
            
        } else {
            allButton.setAttributedTitle(NSAttributedString(string: "전체보기", attributes: [
                .font : UIFont.Notos(.bold, size: 14),
                .foregroundColor : UIColor.mainBlue
            ]), for: .normal)
            allBorderView.backgroundColor = .mainBlue
            subButton.setAttributedTitle(NSAttributedString(string: "둘러보기", attributes: [
                .font : UIFont.Notos(.regular, size: 14),
                .foregroundColor : UIColor.lightGray
            ]), for: .normal)
            subBorderView.backgroundColor = .systemBackground
            allButton.isUserInteractionEnabled = false
            subButton.isUserInteractionEnabled = true
            subVC.view.removeFromSuperview()
            subVC.removeFromParent()
            self.subView.addSubview(mainVC.view)
            mainVC.view.snp.makeConstraints { make in
                make.top.left.right.bottom.equalToSuperview()
            }
            mainVC.dailyButton.addTarget(self, action: #selector(dailyTouchDown), for: .touchDown)
            mainVC.myButton.addTarget(self, action: #selector(myTouchDown), for: .touchDown)
            mainVC.todayButton.addTarget(self, action: #selector(todayTouchDown), for: .touchDown)
            self.addChild(mainVC)
            mainVC.didMove(toParent: self)
        }
    }
    
    @objc func dailyTouchDown() {
        let vc = QuestionAllViewController(title: "일상 이야기",type: "D")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func myTouchDown() {
        let vc = QuestionAllViewController(title: "나의 생각",type: "T")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func todayTouchDown() {
        let vc = QuestionAllViewController(title: "오늘의 오브미",type: "O")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

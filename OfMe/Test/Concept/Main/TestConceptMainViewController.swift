import UIKit

class TestConceptMainViewController: BaseViewController {
    let titleText = "안녕 반가워!\n오늘의 친구야"

    @IBOutlet weak var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "컨셉 추천 받기"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        middleButton?.removeFromSuperview()
    }
    
    @IBAction func startTouchDown(_ sender: Any) {
        let vc = TestConceptDetailFirstViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setUP() {
        let attributedText = NSMutableAttributedString(string: "안녕 반가워!\n오늘의 친구야")
        attributedText.addAttributes([
            .font : UIFont.Notos(.regular, size: 22),
            .foregroundColor : UIColor.label
        ], range: (titleText as NSString).range(of: titleText))
        attributedText.addAttributes([
            .font : UIFont.Notos(.bold, size: 22),
            .foregroundColor : UIColor(hex: 0x1038BC)
        ], range: (titleText as NSString).range(of: "오늘의 친구야"))
        titleLabel.attributedText = attributedText
    }
}

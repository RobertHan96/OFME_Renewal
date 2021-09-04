import UIKit

class TestConceptMainViewController: BaseViewController {
    let titleText = "안녕 반가워!\n오늘의 친구야"

    @IBOutlet weak var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "컨셉 추천 테스트"
    }
    
    @IBAction func startTestButtonDidClicked(_ sender: Any) {
        
        self.navigationController?.pushViewController(TestConceptDetailFirstViewController(), animated: true)
    }
    
    private func setupUI() {
        view.layer.contents = UIImage(named: "test_main_background")?.cgImage
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

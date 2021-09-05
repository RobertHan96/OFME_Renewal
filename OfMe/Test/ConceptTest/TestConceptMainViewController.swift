import UIKit

class TestConceptMainViewController: BaseViewController {
    @IBOutlet weak var titleLabel: UILabel!
    let titleText = "안녕 반가워!\n오늘의 친구야"
    let infromAlert = CustomInformAlert(titleText: "우리 내일 다시 만나요!", subText: "앗! 컨셉 테스트는 한 번만 가능합니다.\n다음에 다시 시도해 주세요.")

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "컨셉 추천 테스트"
    }
    
    @IBAction func startTestButtonDidClicked(_ sender: Any) {
        pushFirstTestViewController()
    }
    
    private func pushFirstTestViewController() {
        TestConceptFirstDataManager().getisAvailableTester { resultCode in
            if resultCode == 1000 {
                self.navigationController?.pushViewController(TestConceptDetailFirstViewController(), animated: true)
            } else {
                print("LOGT", resultCode)
                self.infromAlert.setConstraint(view: self.view)
            }
        }

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

import UIKit

class TestConceptMainViewController: BaseViewController {
    @IBOutlet weak var titleLabel: UILabel!
    var infromAlert = CustomInformAlert(titleText: Strings.alertTitleText, subText: Strings.dailyTestLimitOverAlert)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func startTestButtonDidClicked(_ sender: Any) {
        pushFirstTestViewController()
    }
    
    private func pushFirstTestViewController() {
        if NetworkUtils().checkNetworkConnectivity(currentView: self.view) {
            TestConceptFirstDataManager().getisAvailableTester { resultCode in
                switch  resultCode{
                case ApiCallConstant.responseSuccess :
                    self.navigationController?.pushViewController(TestConceptDetailFirstViewController(), animated: true)
                case TestConceptFirstDataManager().conceptLimitOver:
                    self.infromAlert = CustomInformAlert(titleText: Strings.alertTitleText, subText: Strings.conceptLimitOverAlert)
                    self.infromAlert.setConstraint(view: self.view)
                default:
                    self.infromAlert.setConstraint(view: self.view)
                }
            }
        } 
    }

    private func setupUI() {
        self.navigationItem.title = "컨셉 추천 테스트"
        view.layer.contents = UIImage(named: "test_main_background")?.cgImage
        let attributedText = NSMutableAttributedString(string: Strings.alertTitleText)
        attributedText.addAttributes([
            .font : UIFont.Notos(.regular, size: 22),
            .foregroundColor : UIColor.label
        ], range: (Strings.alertTitleText as NSString).range(of: Strings.alertTitleText))
        attributedText.addAttributes([
            .font : UIFont.Notos(.bold, size: 22),
            .foregroundColor : UIColor(hex: 0x1038BC)
        ], range: (Strings.alertTitleText as NSString).range(of: "오늘의 친구야"))
        titleLabel.attributedText = attributedText
    }
}

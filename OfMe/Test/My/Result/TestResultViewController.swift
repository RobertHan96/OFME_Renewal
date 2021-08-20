import UIKit

class TestResultViewController: BaseViewController {
    private var dataManager: TestMyResultDataManager = TestMyResultDataManager()
    private var circularProgressBar: CircularProgressBar?
    private var idx: Int = 0
    private var answer: [Int] = []
    private var answerSheet: [String] = []

    @IBOutlet weak var preTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var keywordLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    
    init(answer: [Int], answerSheet: [String]) {
        super.init(nibName: "TestResultViewController", bundle: Bundle.main)
        self.answer = answer
        self.answerSheet = answerSheet
        dataManager.getResult(answer: answer, answerSheet: answerSheet) { result in
            UserDefaults.standard.setValue(result.typeId, forKey: "conceptID")
            self.setData(result: result)
        }
    }
    
    init(idx: Int) {
        super.init(nibName: "TestResultViewController", bundle: Bundle.main)
        self.idx = idx
        dataManager.getResult(idx: idx) { result in
            UserDefaults.standard.setValue(result.typeId, forKey: "conceptID")
            self.setData(result: result)
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "나의 성향 알기"
        circularProgressBar = self.tabBarController?.circularProgressBar(duration: 0.6, progress: 1)
        self.view.addSubview(circularProgressBar!)
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        circularProgressBar?.removeFromSuperview()
    }
    
    @IBAction func conceptTouchDown(_ sender: Any) {
        let vc = TestConceptMainViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setData(result: TestMyResult) {
        let attributedString = NSMutableAttributedString(string: result.subName)
        attributedString.addAttributes([
            .font : UIFont.Notos(.regular, size: 12),
            .foregroundColor : UIColor.gray2
        ], range: (result.subName as NSString).range(of: result.subName))
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.thick.rawValue,
                                      range: (result.subName as NSString).range(of: result.subName))
        attributedString.addAttribute(.underlineColor, value: UIColor.gray2,
                                    range: (result.subName as NSString).range(of: result.subName))
        preTitleLabel.attributedText = attributedString
        
        titleLabel.makeHightledText(
            all: result.name,
            for: result.highlight,
            font: .Notos(.bold, size:22))
        keywordLabel.text = result.keyword
        aboutLabel.text = result.description1+"\n"+result.description2
    }
}

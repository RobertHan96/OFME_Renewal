import UIKit

class TestResultViewController: BaseViewController {
    private var dataManager: TestMyResultDataManager = TestMyResultDataManager()
    private var idx: Int = 0
    private var answer: [Int] = []
    private var answerSheet: [String] = []

    @IBOutlet weak var preTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var keywordLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        self.navigationItem.title = "나의 성향 알기"
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
}

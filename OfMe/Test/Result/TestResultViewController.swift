import UIKit

class TestResultViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var confrimConceptButton: UIButton!
    var testResult: TestMyResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchData()
    }
    
    private func setupUI() {
        self.navigationItem.title = "컨셉 추천 결과"
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    private func fetchData() {
        let firstAnswerIdx = UserDefaults().integer(forKey: Strings.userDefaultStageOneResult)
        let secondAnswerIdx = UserDefaults().integer(forKey: Strings.userDefaultStageTwoResult)
        TestMyResultDataManager().getResult(firstAnswer: firstAnswerIdx, secondAnswer: secondAnswerIdx) { data in
            self.testResult = data
        }
    }
    
    private func confirmConcept() {
        guard let id = testResult?.id else { return }
        TestMyResultDataManager().confrimTestResult(conceptId: id) { resultCode in
            if resultCode == 1000 { // 메인으로 이동안되는 오류 수정 필요
                self.navigationController?.popToRootViewController(animated: true)
            }
            print("LOG:", resultCode)
        }
    }

    @IBAction func confrimConcept(_ sender: UIButton) {
        confirmConcept()
    }
}

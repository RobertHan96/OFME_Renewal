import UIKit

class TestResultViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var confrimConceptButton: UIButton!
    var testResult: TestMyResult? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchData()
    }
    
    private func setupUI() {
        setupTableView()
        self.navigationItem.title = "컨셉 추천 결과"
        self.navigationItem.setHidesBackButton(true, animated: false)
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: CellManager.CharacterInfoCellName, bundle: nil), forCellReuseIdentifier: CellManager.CharacterInfoCellIdentifier)
        tableView.register(UINib.init(nibName: CellManager.CharacterSummaryCellName, bundle: nil), forCellReuseIdentifier: CellManager.CharacterSummaryCellIdentifier)
    }

    private func fetchData() {
        let firstAnswerIdx = UserDefaults().integer(forKey: Strings.userDefaultStageOneResult)
        let secondAnswerIdx = UserDefaults().integer(forKey: Strings.userDefaultStageTwoResult)
        print("LOG")
        TestMyResultDataManager().getResult(firstAnswer: firstAnswerIdx, secondAnswer: secondAnswerIdx) { data in
            self.testResult = data
            print("LOG", data)
        }
    }
    
    private func confirmConcept() {
        guard let id = testResult?.id else { return }
        TestMyResultDataManager().confrimTestResult(conceptId: id) { resultCode in
            if resultCode == 1000 { // 메인으로 이동안되는 오류 수정 필요
                let vc = HomeMainViewController()
                self.navigationController?.popToRootViewController(animated: true)
//                UIApplication.shared.keyWindow?.replaceRootViewController(vc, animated: true, completion: nil)
                return
            }
            print("LOG:", resultCode)
        }
    }
    
    @IBAction func confrimConcept(_ sender: UIButton) {
        confirmConcept()
    }
}

extension TestResultViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 211
        default:
            return 200
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0: // 시간 정보 표시 Cell
            guard let characterSummaryCell = tableView.dequeueReusableCell(withIdentifier: CellManager.CharacterSummaryCellIdentifier) as? CharacterSummaryCell else { return UITableViewCell() }
                characterSummaryCell.configure(data: testResult)
            
            return characterSummaryCell
        default :
            guard let characterInfoCell = tableView.dequeueReusableCell(withIdentifier: CellManager.CharacterInfoCellIdentifier) as? CharacterInfoCell else { return UITableViewCell() }
            guard let testResult = testResult else { return UITableViewCell() }
            characterInfoCell.configure(testResult: testResult)
            return characterInfoCell
        }
    }
}

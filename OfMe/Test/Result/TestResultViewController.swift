import UIKit

class TestResultViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var confrimConceptButton: UIButton!
    var coachmarkCount: Int = 0 // 코치마크를 1번만 보여주게 하기 위한 카운트 변수
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        TestMyResultDataManager().getResult(firstAnswer: firstAnswerIdx, secondAnswer: secondAnswerIdx) { data in
            self.testResult = data
            if self.testResult != nil {
                self.setCoachmarkerView()
            }
        }
    }
    
    private func confirmConcept() {
        guard let id = testResult?.id else { return }
        TestMyResultDataManager().confrimTestResult(conceptId: id) { resultCode in
            if resultCode == 1000 {
                self.changeRootViewController(BaseTabBarController().initMainTabBar())
            }
            self.presentAlert(title: "네트워크 오류로 정보를 불러오지 못했습니다.\n 코드 : \(resultCode)")
        }
    }
    
    private func setCoachmarkerView() {
        if hasAppBeenLaunchedBefore() == false && coachmarkCount == 0 {
            let vc = CoachmarkerViewController(coachMarkCase: .testResultFirst)
            self.navigationController?.pushViewController(vc, animated: false)
        } else {
            print("LOG: 이전에 앱 실행 경험 있음, 코치마크 튜토리얼 생략")
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

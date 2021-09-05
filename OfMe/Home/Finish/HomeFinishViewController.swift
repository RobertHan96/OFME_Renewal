import UIKit

protocol HomeFinishViewControllerDelegate {
    func starRatingDidClicked(ratingPoint: Int)
}

class HomeFinishViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomInfromText: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var ratingLaterButton: UIButton!
    let infromAlert = CustomInformAlert(titleText: "잠깐!", subText: "컨셉을 종료하기 위해 만족한 만큼\n별점을 표시해주세요.")
    var finishData = FinishEnd(timer: 0, url: "https://ofmebucket.s3.ap-northeast-2.amazonaws.com/01_default_1.png", conceptId: 1)
    var delegate: HomeFinishViewControllerDelegate?
    private var idx: Int = -1
    
    init(finishData: FinishEnd) {
        super.init(nibName: "HomeFinishViewController", bundle: Bundle.main)
        self.finishData = finishData
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        setupTableView()
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib.init(nibName: CellManager.ConceptResultSummaryCellName, bundle: nil), forCellReuseIdentifier: CellManager.ConceptResultSummaryCellIdentifier)
        tableView.register(UINib.init(nibName: CellManager.StepCellName, bundle: nil), forCellReuseIdentifier: CellManager.StepCellIdentifier)
        tableView.register(UINib.init(nibName: CellManager.StarRatingCellName, bundle: nil), forCellReuseIdentifier: CellManager.StarRatingCellIdentifier)
        tableView.register(UINib.init(nibName: CellManager.FinishButtonCellName, bundle: nil), forCellReuseIdentifier: CellManager.FinishButtonCellIdentifier)
    }

    @IBAction func laterTouchDown(_ sender: Any) {

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "컨셉 종료 평가"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    }
}

extension HomeFinishViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 144
        case 2:
            return 166
        case 1,3:
            return 70
        default:
            return 200
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let conceptResultSummaryCell = tableView.dequeueReusableCell(withIdentifier: CellManager.ConceptResultSummaryCellIdentifier) as? ConceptResultSummaryCell else { return UITableViewCell() }
            conceptResultSummaryCell.configure(time: finishData.timer, url: finishData.url)
            
            return conceptResultSummaryCell
        case 2:
            guard let starRatingCell = tableView.dequeueReusableCell(withIdentifier: CellManager.StarRatingCellIdentifier) as? StarRatingCell else { return UITableViewCell() }
            starRatingCell.delegate = self

            return starRatingCell
        case 1, 3:
            guard let firstStepCell = tableView.dequeueReusableCell(withIdentifier: CellManager.StepCellIdentifier) as? StepCell else { return UITableViewCell() }
            firstStepCell.configure(step: indexPath.section)
            
            return firstStepCell
        default:
            guard let buttonsCell = tableView.dequeueReusableCell(withIdentifier: CellManager.FinishButtonCellIdentifier) as? FinishButtonCell else { return UITableViewCell() }
            buttonsCell.delegate = self
            self.delegate = buttonsCell
            
            return buttonsCell
        }
    }
}

extension HomeFinishViewController: StarRatingCellDelegate, FinishButtonCellDelegate {
    func ratingLaterButtonDidClicked() {
        // 나중에 하기 팝업에 맞는 화면 레이아웃으로 변경 필요
        infromAlert.setConstraint(view: self.view)
    }
    
    func endConceptButtonDidClicked(isValidEndRequest: Bool) {
        print("LOG:컨셉 평가 API 호출")

        if isValidEndRequest {
            FinishDataManager().patchRate(ratingPoint: idx) { patchResult in
                if patchResult == 1000 {
                    let vc = HomeMainViewController()
                    UIApplication.shared.keyWindow?.replaceRootViewController(vc, animated: true, completion: nil)
                    return
                } else {
                    self.presentAlert(title: Strings.PatchConceptRatingFaildAlert)
                }
            }
        }
    }
    
    func starRatingDidClicked(ratingPoint: Int) {
        idx = ratingPoint
        delegate?.starRatingDidClicked(ratingPoint: idx)
    }
}

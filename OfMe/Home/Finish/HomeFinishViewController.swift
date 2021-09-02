import UIKit

class HomeFinishViewController: BaseViewController {
    private var dataManager = FinishDataManager()
    private var idx: Int = -1
    private var time: Int = 0
    private var data: CharacterResult = CharacterResult(nickname: "", name: "", id: 0, url: "", timer: 0)

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomInfromText: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var ratingLaterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()        
    }
    
    private func setupUI() {
        nextButton.isUserInteractionEnabled = false
        nextButton.backgroundColor = .ofMeColor
        setupTableView()
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib.init(nibName: CellManager.ConceptResultSummaryCellName, bundle: nil), forCellReuseIdentifier: CellManager.ConceptResultSummaryCellIdentifier)
        tableView.register(UINib.init(nibName: CellManager.StepCellName, bundle: nil), forCellReuseIdentifier: CellManager.StepCellIdentifier)
        tableView.register(UINib.init(nibName: CellManager.StarRatingCellName, bundle: nil), forCellReuseIdentifier: CellManager.StarRatingCellIdentifier)
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
        case 1, 3:
            return 70
        case 2:
            return 166
        case 4:
            return 40
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let conceptResultSummaryCell = tableView.dequeueReusableCell(withIdentifier: CellManager.ConceptResultSummaryCellIdentifier) as? ConceptResultSummaryCell else { return UITableViewCell() }
            conceptResultSummaryCell.configure(time: 1000)
            
            return conceptResultSummaryCell
        case 1, 3:
            guard let firstStepCell = tableView.dequeueReusableCell(withIdentifier: CellManager.StepCellIdentifier) as? StepCell else { return UITableViewCell() }
            firstStepCell.configure(step: indexPath.section)
            
            return firstStepCell
        case 2:
            guard let starRatingCell = tableView.dequeueReusableCell(withIdentifier: CellManager.StarRatingCellName) as? StarRatingCell else { return UITableViewCell() }
            starRatingCell.delegate = self
            starRatingCell.backgroundColor = .brown
            return starRatingCell
        default:
            return UITableViewCell()
        }
    }

    
}

extension HomeFinishViewController: StarRatingCellDelegate {
    func starRatingDidClicked() {
        nextButton.isUserInteractionEnabled = true
        print("별점 눌림")
    }
        
}

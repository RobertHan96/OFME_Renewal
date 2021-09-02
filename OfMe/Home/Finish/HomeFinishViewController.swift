import UIKit

class HomeFinishViewController: BaseViewController {
    private var dataManager = FinishDataManager()
    private var idx: Int = -1
    private var time: Int = 0
    private var data: CharacterResult = CharacterResult(nickname: "", name: "", id: 0, url: "", timer: 0)

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var ratingLaterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()        
    }
    
    private func setupUI() {
        nextButton.isUserInteractionEnabled = false
        setupTableView()
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 144
        case 1:
            return 70
        case 2:
            return 166
        case 3:
            return 70
        case 4:
            return 40
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = UITableViewCell()
            cell.backgroundColor = .blue
            return cell
        case 1:
            let cell = UITableViewCell()
            cell.backgroundColor = .black
            return cell
        case 2:
            let cell = UITableViewCell()
            cell.backgroundColor = .gray
            return cell
        case 3:
            let cell = UITableViewCell()
            cell.backgroundColor = .magenta
            return cell
        case 4:
            let cell = UITableViewCell()
            cell.backgroundColor = .purple
            return cell
        default:
            return UITableViewCell()
        }
    }

    
}

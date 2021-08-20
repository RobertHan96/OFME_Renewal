import UIKit

class QuestionMainViewController: BaseViewController {
    private let dataManager = SubAllDataManager()
    private var today: [SubAllQuestion] = []
    private var daily: [SubAllQuestion] = []
    private var my: [SubAllQuestion] = []

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var dailyLabel: UILabel!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var todayButton: UIButton!
    @IBOutlet weak var dailyButton: UIButton!
    @IBOutlet weak var myButton: UIButton!
    @IBOutlet weak var todayCollectionView: UICollectionView!
    @IBOutlet weak var dailyCollectionView: UICollectionView!
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [todayLabel, dailyLabel, myLabel].forEach { $0.font = .Notos(.bold, size: 15) }
        scrollView.contentSize.width = UIScreen.main.bounds.width
        todayButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(UIScreen.main.bounds.width-90)
            make.centerY.equalTo(todayLabel)
            make.width.equalTo(55)
        }
        dailyButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(UIScreen.main.bounds.width-90)
            make.centerY.equalTo(dailyLabel)
            make.width.equalTo(55)
        }
        myButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(UIScreen.main.bounds.width-90)
            make.centerY.equalTo(myLabel)
            make.width.equalTo(55)
        }
        [todayCollectionView, dailyCollectionView, myCollectionView].forEach {
            $0?.snp.makeConstraints { make in
                make.width.equalTo(UIScreen.main.bounds.width)
            }
            $0?.register(UINib(nibName: QuestionMainCell.identfier, bundle: nil), forCellWithReuseIdentifier: QuestionMainCell.identfier)
            $0?.delegate = self
            $0?.dataSource = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Q&A"
        dataManager.getQuestion { data in
            self.today.removeAll()
            self.daily.removeAll()
            self.my.removeAll()
            data.forEach {
                if $0.sort == "O" {
                    self.today.append($0)
                } else if $0.sort == "D" {
                    self.daily.append($0)
                } else {
                    self.my.append($0)
                }
            }
            self.today.sort { data, _ in
                    if let _ = data.share { return true }
                    else { return false }
            }
            self.daily.sort { data, _ in
                    if let _ = data.share { return true }
                    else { return false }
            }
            self.my.sort { data, _ in
                    if let _ = data.share { return true }
                    else { return false }
            }
            [self.myCollectionView, self.todayCollectionView, self.dailyCollectionView].forEach { $0?.reloadData() }
        }
    }
    
    @objc func todayChange(_ sender: UIButton) {
        let vc = QuestionWriteViewController(id: today[sender.tag].id, data: today[sender.tag], isEdit: true)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func dailyChange(_ sender: UIButton) {
        let vc = QuestionWriteViewController(id: daily[sender.tag].id, data: daily[sender.tag], isEdit: true)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func myChange(_ sender: UIButton) {
        let vc = QuestionWriteViewController(id: my[sender.tag].id, data: my[sender.tag], isEdit: true)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func todayTouchDown(_ sender: Any) {
        
    }
    
    @IBAction func dailyTouchDown(_ sender: Any) {
    }
    
    @IBAction func myTouchDown(_ sender: Any) {
    }
}

extension QuestionMainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:
            return today.count
        case 1:
            return daily.count
        default:
            return my.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuestionMainCell.identfier, for: indexPath) as? QuestionMainCell else {
            return UICollectionViewCell()
        }
        switch collectionView.tag {
        case 0:
            cell.changeButton.tag = indexPath.row
            cell.changeButton.addTarget(self, action: #selector(todayChange(_:)), for: .touchDown)
            cell.updateUI(data: today[indexPath.row])
            return cell
        case 1:
            cell.changeButton.tag = indexPath.row
            cell.changeButton.addTarget(self, action: #selector(dailyChange(_:)), for: .touchDown)
            cell.updateUI(data: daily[indexPath.row])
            return cell
        default:
            cell.changeButton.tag = indexPath.row
            cell.changeButton.addTarget(self, action: #selector(myChange(_:)), for: .touchDown)
            cell.updateUI(data: my[indexPath.row])
            return cell
        }
    }
    
}

extension QuestionMainViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var idx: Int
        var data: SubAllQuestion
        switch collectionView.tag {
        case 0:
            data = today[indexPath.row]
            idx = today[indexPath.row].id
        case 1:
            data = daily[indexPath.row]
            idx = daily[indexPath.row].id
        default:
            data = my[indexPath.row]
            idx = my[indexPath.row].id
        }
        let vc = QuestionWriteViewController(id: idx,data: data, isEdit: false)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 185)
    }
}

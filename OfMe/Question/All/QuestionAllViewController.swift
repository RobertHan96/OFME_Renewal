import UIKit

class QuestionAllViewController: BaseViewController {
    private let dataManager = QuestionAllDataManager()
    private var type: String = ""
    private var data: [SubAllQuestion] = []
    private var idx: Int = 0
    private var titles: [String] = ["모든질문", "공유완료" ,"답변완료", "미답변"]
    private var navTitle: String = ""
    
    @IBOutlet weak var subCollectionView: UICollectionView!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    init(title navTitle: String, type: String) {
        super.init(nibName: "QuestionAllViewController", bundle: nil)
        self.navTitle = navTitle
        self.type = type
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = navTitle
        
        subCollectionView.register(UINib(nibName: QuestionMenuCell.identifier, bundle: nil), forCellWithReuseIdentifier: QuestionMenuCell.identifier)
        subCollectionView.tag = 0
        subCollectionView.delegate = self
        subCollectionView.dataSource = self
        
        mainCollectionView.tag = 1
        mainCollectionView.register(UINib(nibName: QuestionMainCell.identfier, bundle: nil), forCellWithReuseIdentifier: QuestionMainCell.identfier)
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        middleButton = self.tabBarController?.normalMiddleButton()
        dataManager.getQuestion(sort: type, answers: idx) { data in
            self.data = data
            self.data.sort { data, _ in
                    if let _ = data.share { return true }
                    else { return false }
            }
            [self.subCollectionView,self.mainCollectionView].forEach { $0?.reloadData() }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        middleButton?.removeFromSuperview()
    }
    
    @objc func updateButton(_ sender: UIButton) {
        let vc = QuestionWriteViewController(id: data[sender.tag].id, data: data[sender.tag], isEdit: true)
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

extension QuestionAllViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:
            return 4
        default:
            if idx == 0 {
                return data.count
            } else if idx == 1 {
                return data.filter { q in
                    if q.share != nil {
                        return q.share! == "Y" ? true : false
                    } else {
                        return false
                    }
                }.count
            } else {
                return data.filter { q in
                    return q.share == nil ? true : false
                }.count
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuestionMenuCell.identifier, for: indexPath) as? QuestionMenuCell else {
                return UICollectionViewCell()
            }
            cell.updateUI(row: indexPath.row, idx: idx, title: titles[indexPath.row])
            return cell
        default:
            var data = data
            if idx == 1 {
                data = data.filter { q in
                    if q.share != nil {
                        return q.share! == "Y" ? true : false
                    } else {
                        return false
                    }
                }
            } else if idx == 2{
                data = data.filter { q in
                    return q.share == nil ? true : false
                }
            }
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuestionMainCell.identfier, for: indexPath) as? QuestionMainCell else {
                return UICollectionViewCell()
            }
            cell.changeButton.tag = indexPath.row
            cell.changeButton.addTarget(self, action: #selector(updateButton(_:)), for: .touchDown)
            cell.updateUI(data: data[indexPath.row])
            return cell
        }
    }
}

extension QuestionAllViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView.tag {
        case 0:
            idx = indexPath.row
            dataManager.getQuestion(sort: type, answers: idx) { data in
                self.data = data
                self.data.sort { data, _ in
                        if let _ = data.share { return true }
                        else { return false }
                }
                [self.subCollectionView, self.mainCollectionView].forEach { $0?.reloadData() }
            }
        default:
            let vc = QuestionWriteViewController(id: data[indexPath.row].id, data: data[indexPath.row], isEdit: false)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView.tag {
        case 0:
            return CGSize(width: calculateWidth(collectionView: collectionView, row: indexPath.row)+50, height: 25)
        default:
            return CGSize(width: collectionView.frame.width/2-30, height: 185)
        }
    }
    
    func calculateWidth(collectionView: UICollectionView, row: Int) -> CGFloat {
        let view = UIView(frame: collectionView.frame)
        let label = UILabel(frame: collectionView.frame)
        label.font = .Notos(.regular, size: 12)
        label.text = titles[row]
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        label.sizeToFit()
        return label.frame.width
    }
}

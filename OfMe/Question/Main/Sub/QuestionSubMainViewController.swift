import UIKit

class QuestionSubMainViewController: BaseViewController {
    private let dataManager = SubAllDataManager()
    private let subView = QuestionSubView()
    private let titles: [String] = ["모든질문", "내가 공유한 Q&A", "확인완료", "미확인"]
    private let urls: [String] = [URLString.questionEvery,URLString.questionShare,URLString.questionCheck,URLString.questionNoCheck]
    private var idx: Int = 0
    private var data: [QuestionView] = []

    @IBOutlet weak var QACountLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var contentCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [QACountLabel, pointLabel].forEach { $0.font = .Notos(.bold, size: 16) }
        collectionView.register(UINib(nibName: QuestionMenuCell.identifier, bundle: nil), forCellWithReuseIdentifier: QuestionMenuCell.identifier)
        collectionView.tag = 0
        collectionView.delegate = self
        collectionView.dataSource = self
        
        contentCollectionView.tag = 1
        contentCollectionView.register(UINib(nibName: QuestionSubCell.identifier, bundle: nil), forCellWithReuseIdentifier: QuestionSubCell.identifier)
        contentCollectionView.delegate = self
        contentCollectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dataManager.getReward(completed: {
            self.QACountLabel.text = "\($0.first!.countQnA)"
            self.pointLabel.text = "\($0.first!.sumPoint)p"
        })
        dataManager.getQuestionView(url: urls[idx]) { data in
            self.data = data
            self.collectionView.reloadData()
            self.contentCollectionView.reloadData()
        }
    }
    
    @objc func buttonTouchDown(_ sender: UIButton) {
        subView.confrimView.removeFromSuperview()
        dataManager.getQuestionDetail(id: data[sender.tag].questionId) { response in
            if response.code == 3140 {
                self.subView.addQuitView(self.view)
            } else if response.code == 1000 {
                let vc = QuestionSubViewController(titleText: self.data[sender.tag].question, data: response.result!)
                self.navigationController?.pushViewController(vc, animated: true)
            } else if response.code == 3141{
                self.subView.addNoView(self.view)
            } else {
                self.presentAlert(title: "다시 시도해 주시기 바랍니다.")
            }
        }
    }
}

extension QuestionSubMainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:
            return 4
        default:
            return data.count
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
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuestionSubCell.identifier, for: indexPath) as? QuestionSubCell else {
                return UICollectionViewCell()
            }
            cell.updateUI(data: data[indexPath.row])
            return cell
        }
    }
    
    
}

extension QuestionSubMainViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView.tag {
        case 0:
            idx = indexPath.row
            dataManager.getQuestionView(url: urls[idx]) { data in
                self.data = data
                self.collectionView.reloadData()
                self.contentCollectionView.reloadData()
                self.dataManager.getReward(completed: {
                    self.QACountLabel.text = "\($0.first!.countQnA)"
                    self.pointLabel.text = "\($0.first!.sumPoint)p"
                })
            }
            collectionView.reloadData()
        default:
            if data[indexPath.row].aroundId == nil {
                subView.addConfrimView(self.view)
                subView.useButton?.tag = indexPath.row
                subView.useButton?.addTarget(self, action: #selector(buttonTouchDown(_:)), for: .touchDown)
            } else {
                dataManager.getQuestionDetail(id: data[indexPath.row].questionId) { response in
                    if response.code == 3140 {
                        self.subView.addQuitView(self.view)
                    } else if response.code == 1000 {
                        let vc = QuestionSubViewController(titleText: self.data[indexPath.row].question, data: response.result!)
                        self.navigationController?.pushViewController(vc, animated: true)
                    } else if response.code == 3141{
                        self.subView.addNoView(self.view)
                    } else {
                        self.presentAlert(title: "다시 시도해 주시기 바랍니다.")
                    }
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView.tag {
        case 0:
            return CGSize(width: calculateWidth(collectionView: collectionView, row: indexPath.row)+50, height: 25)
        default:
            return CGSize(width: collectionView.frame.width/2-35, height: 185)
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

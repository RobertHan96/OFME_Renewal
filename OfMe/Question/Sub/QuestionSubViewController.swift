import UIKit

class QuestionSubViewController: BaseViewController {
    private let dataManager = QuestionSubDataManager()
    private var titleText = ""
    private var data: [QuestionDetail] = []
    private var tags: [Int: Int] = [:]

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    init(titleText:String, data: [QuestionDetail]) {
        super.init(nibName: "QuestionSubViewController", bundle: nil)
        self.titleText = titleText
        self.data = data
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countLabel.font = .Notos(.regular, size: 12)
        countLabel.textColor = .gray3
        
        titleLabel.font = .Notos(.bold, size: 18)
        titleLabel.textColor = .mainBlue
        titleLabel.text = titleText
        
        collectionView.register(UINib(nibName: CommentCell.identifier, bundle: nil), forCellWithReuseIdentifier: CommentCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        countLabel.text = "총 답변 \(data.count)개"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "둘러보기"
        middleButton = self.tabBarController?.normalMiddleButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        middleButton?.removeFromSuperview()
    }
    
    @objc func action(_ sender: UIButton) {
        dataManager.declarations(idx: sender.tag) {
            if $0 == 1000 {
                self.presentAlert(title: "신고 되었습니다.")
            } else {
                self.presentAlert(title: "다시 시도해 주시기 바랍니다.")
            }
        }
    }
    
}

extension QuestionSubViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommentCell.identifier, for: indexPath) as? CommentCell else {
            return UICollectionViewCell()
        }
        cell.updateUI(data: data[indexPath.row])
        tags[data[indexPath.row].answerId] = indexPath.row
        cell.actionButton.addTarget(self, action: #selector(action(_:)), for: .touchDown)
        return cell
    }
    
    
}

extension QuestionSubViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width-60, height: resizeHeight(collectionView, text: "label")+90)
    }
    
    func resizeHeight(_ collectionView: UICollectionView, text: String) -> CGFloat {
        let view = UIView(frame: collectionView.frame)
        let label = UILabel(frame: collectionView.frame)
        label.numberOfLines = 0
        label.font = .Notos(.regular, size: 12)
        label.text = text
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(30)
            make.top.equalToSuperview()
        }
        label.sizeToFit()
        return label.frame.height
    }
}

import UIKit

class MyInfoMainViewController: BaseViewController {
    private let dataManager = MyInfoDataManager()
    private let titles: [String] = ["서비스 이용약관", "개인정보 처리방침"]
    private var history: [MyHistory] = []
    private var char: [MyFriend] = []
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var conceptCollectionView: UICollectionView!
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var charLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var attrLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width)
        }
        nameLabel.font = .Notos(.bold, size: 20)
        charLabel.font = .Notos(.regular, size: 14)
        [pointLabel, attrLabel].forEach {
            $0.font = .Notos(.bold, size: 14)
        }
        pointLabel.isHidden = false
        pointLabel.textColor = .white
        
        menuCollectionView.tag = 2
        menuCollectionView.register(UINib(nibName: InfoMenuCell.identifier, bundle: nil), forCellWithReuseIdentifier: InfoMenuCell.identifier)
        menuCollectionView.dataSource = self
        menuCollectionView.delegate = self
        
        myCollectionView.tag = 1
        myCollectionView.register(UINib(nibName: MyInfoHistoryCell.identifier, bundle: nil), forCellWithReuseIdentifier: MyInfoHistoryCell.identifier)
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        
        conceptCollectionView.tag = 0
        conceptCollectionView.register(UINib(nibName: MyInfoCharCell.identifier, bundle: nil), forCellWithReuseIdentifier: MyInfoCharCell.identifier)
        conceptCollectionView.dataSource = self
        conceptCollectionView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "마이페이지"
        
        dataManager.getInfo() { data in
            print(data.selectMypageResult)
            self.history = data.selectMyhistoryResult
            if data.selectMypageResult.count > 0 {
                self.nameLabel.text = data.selectMypageResult[0].nickname
                self.pointLabel.text = "\(data.selectMypageResult[0].point)p"
                if data.selectMypageResult[0].name != nil {
                    self.charLabel.text = "오늘의 친구 \(data.selectMypageResult[0].name!)"
                }
                self.imageView.kf.setImage(with: URL(string: data.selectMypageResult[0].imgUrl))
                if data.selectMypageResult[0].highlight != nil{
                    self.attrLabel.text = data.selectMypageResult[0].highlight!
                }
                self.myCollectionView.reloadData()
                self.char = data.selectMyfriendResult
                self.conceptCollectionView.reloadData()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        middleButton?.removeFromSuperview()
    }
    
    @IBAction func actionTouchDown(_ sender: Any) {
        let vc = InfoDetailViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MyInfoMainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 2:
            return 2
        case 1:
            return history.count
        default:
            return char.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfoMenuCell.identifier, for: indexPath) as? InfoMenuCell else {
                return UICollectionViewCell()
            }
            cell.updateUI(text: titles[indexPath.row])
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyInfoHistoryCell.identifier, for: indexPath) as? MyInfoHistoryCell else {
                return UICollectionViewCell()
            }
            cell.updateUI(data: history[indexPath.row])
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyInfoCharCell.identifier, for: indexPath) as? MyInfoCharCell else {
                return UICollectionViewCell()
            }
            cell.updateUI(data: char[indexPath.row])
            return cell
        }
    }
    
    
}

extension MyInfoMainViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            UIApplication.shared.open(URL(string: "https://periodic-case-901.notion.site/OFME-cbc064fe679945008a5195438831f035")!, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.open(URL(string: "https://periodic-case-901.notion.site/OFME-1bac7bfbbef04f2dbd2f511065221a6e")!, options: [:], completionHandler: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView.tag {
        case 2:
            return CGSize(width: collectionView.frame.width, height: 75)
        case 1:
            return CGSize(width: 75, height: 75)
        default:
            return CGSize(width: 75, height: 110)
        }
    }
}

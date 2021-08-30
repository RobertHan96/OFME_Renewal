import UIKit

class InfoDetailViewController: BaseViewController {
    private let dataManager = InfoDetailDataManager()
    private let titles: [String] = ["닉네임 변경","비밀번호 변경","로그아웃","회원탈퇴"]
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.font = .Notos(.bold, size:20)
        emailLabel.font = .Notos(.regular, size:14)
        
        collectionView.register(UINib(nibName: InfoMenuCell.identifier, bundle: nil), forCellWithReuseIdentifier: InfoMenuCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "내 정보"
        
        dataManager.getDetail() { data in
            if data.count > 0 {
                self.nameLabel.text = data.last!.nickname
                self.emailLabel.text = data.last!.email
                if let url = URL(string: data.last!.imgUrl) {
                    self.imageView.kf.setImage(with: url)
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        middleButton?.removeFromSuperview()
    }
}

extension InfoDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfoMenuCell.identifier, for: indexPath) as? InfoMenuCell else {
            return UICollectionViewCell()
        }
        cell.updateUI(text: titles[indexPath.row])
        return cell
    }
    
    
}

extension InfoDetailViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let vc = FixNameViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = FixPasswordViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            dataManager.logout { result in
                if result == 1000 {
                    let vc = UINavigationController(rootViewController: LoginMainViewController())
                    self.navigationController?.changeRootViewController(vc)
                }
            }
        default:
            let vc = DeleteUserViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 60)
    }
}

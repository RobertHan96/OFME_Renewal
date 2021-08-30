import UIKit

class HomeFinishViewController: BaseViewController {
    private var dataManager = FinishDataManager()
    private var idx: Int = -1
    private var time: Int = 0
    private var data: CharacterResult = CharacterResult(nickname: "", name: "", id: 0, url: "", timer: 0)

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var descriptLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    
    init(data: CharacterResult, time: Int) {
        super.init(nibName: "HomeFinishViewController", bundle: Bundle.main)
        self.data = data
        self.time = time
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let hour = time / 60
        time = time % 60
        let timeText = "\(hour > 0 ? "\(hour)시간 \(time)분" : "\(time)분")"
        timeLabel.makeHightledText(all: "\(data.name!)과 함께한 시간    \(timeText)", for: "\(timeText)")
        pointLabel.makeHightledText(all: "예상포인트 5p", for: "5p", font: .Notos(.regular, size: 11))
        
        descriptLabel.font = .Notos(.regular, size: 12)
        descriptLabel.text = "헤헤.. \(data.nickname)!\n나와 함께해줘서고마워\n다음에 또 보자 :)"
        nextButton.isUserInteractionEnabled = false
        
        if let url = URL(string: data.url!) {
            imageView.kf.setImage(with: url)
        }
        print(data)
        collectionView.register(UINib(nibName: StarCell.identifier, bundle: nil), forCellWithReuseIdentifier: StarCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    @IBAction func laterTouchDown(_ sender: Any) {
        dataManager.patchFinish(time: time) {
            self.dataManager.patchRate(idx: self.idx+1, id: $0) {
                if $0 == 1000 {
                    self.navigationController?.viewControllers.forEach {
                        if $0 is HomeMainViewController {
                            if let vc = $0 as? HomeMainViewController {
                                print("change")
                                vc.changeIsFirst()
                                self.navigationController?.popToViewController(vc, animated: true)
                            }
                        }
                    }
                } else {
                    self.presentAlert(title: "다시 시도해 주시기 바랍니다.")
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "컨셉 종료 평가"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        middleButton?.removeFromSuperview()
    }
}

extension HomeFinishViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StarCell.identifier, for: indexPath) as? StarCell else {
            return UICollectionViewCell()
        }
        cell.updateUI(row: indexPath.row, idx: idx)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
}

extension HomeFinishViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        idx = indexPath.row
        if idx != -1 {
            nextButton.isUserInteractionEnabled = true
        }
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 44, height: 44)
    }
}

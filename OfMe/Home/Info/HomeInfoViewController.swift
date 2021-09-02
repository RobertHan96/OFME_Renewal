import UIKit

class HomeInfoViewController: BaseViewController {
    private var dataManager = ConceptResultDataManager()
    private var adapter: ConceptResultAdapter?
    private var idx: Int = 0

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    init(idx: Int) {
        super.init(nibName: "HomeInfoViewController", bundle: Bundle.main)
        self.idx = idx
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUP()
        dataManager.getConceptResult(idx: idx) { result in
            print(result)
            if !result.isEmpty {
                self.adapter = ConceptResultAdapter(of: self.collectionView, sub: self.pageControl, data: result[0])
                if let url = URL(string: result[0].url) {
                    self.mainImageView.kf.setImage(with: url)
                }
                self.titleLabel.text = result[0].name
                self.mainLabel.text = result[0].subName
                self.subLabel.text = result[0].description
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "캐릭터 특징"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        middleButton?.removeFromSuperview()
    }
    
    func setUP() {
        titleLabel.font = .Notos(.bold, size: 22)
        titleLabel.textColor = .mainBlue
        
        mainLabel.font = .Notos(.regular, size: 13)
        subLabel.font = .Notos(.regular, size: 12)
        subLabel.textColor = .gray2
        
        pageControl.numberOfPages = 5
        pageControl.currentPage = 0
    }

}

import UIKit

class TestConceptSecondViewController: BaseViewController {
    static let identifier = "TestConceptSecondViewController"
    private let dataManager: TestConceptSecondDataManager = TestConceptSecondDataManager()
    private var data: TestConceptSecond?
    private var secondIdx: Int = -1
    private var firstIdx: Int = 0
    private var circularProgressBar: CircularProgressBar?
    private var adapter: ConceptSecondAdapter?
    private var menu: ConceptFirstMenu?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    init(firstIdx: Int) {
        super.init(nibName: TestConceptSecondViewController.identifier, bundle: Bundle.main)
        self.firstIdx = firstIdx
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menu = ConceptFirstMenu()
        menu?.nextButton.setTitle("다음", for: .normal)
        menu?.nextButton.addTarget(self, action: #selector(nextStageButtonDidClicked(_:)), for: .touchDown)
        dataManager.getTest(idx: firstIdx) { result in
            self.data = result
            self.adapter = ConceptSecondAdapter(of: self.collectionView, data: result) { idx in
                switch idx {
                case -1:
                    self.menu?.nextButton.removeFromSuperview()
                    self.secondIdx = -1
                default:
                    UserDefaults.standard.setValue(idx, forKey: "stageTwoResult")
                    self.menu?.setButton(view: self.view)
                    self.secondIdx = idx - 1
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "컨셉 추천 받기"
        circularProgressBar = self.tabBarController?.circularProgressBar(duration: 0.6, progress: 2/3+0.1)
        self.view.addSubview(circularProgressBar!)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        circularProgressBar?.removeFromSuperview()
    }
    
    @objc func nextStageButtonDidClicked(_ sender: UIButton) {
        let vc = TestConceptThirdViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

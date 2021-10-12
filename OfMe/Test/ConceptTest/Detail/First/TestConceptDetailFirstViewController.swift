import UIKit

class TestConceptDetailFirstViewController: BaseViewController {
    private var dataManager: TestConceptFirstDataManager = TestConceptFirstDataManager()
    private var adapter: ConceptFirstAdapter?
    private var menu: NextConceptButtonView?
    private var data: [TestConceptFirst] = []
    private var index: Int = -1
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menu = NextConceptButtonView()
        setupUI()
        fetchData()
    }
    
    private func setupUI() {
        self.navigationItem.title = "컨셉 추천 테스트"
        menu?.nextButton.addTarget(self, action: #selector(nextStageButtonDidClicked(_:)), for: .touchDown)
    }
    
    private func fetchData() {
        dataManager.getFirstTest { result in
            self.adapter = ConceptFirstAdapter(of: self.collectionView, data: result) { idx in
                self.index = idx
                switch idx {
                case -1:
                    self.menu?.nextButton.removeFromSuperview()
                default:
                    self.menu?.setButton(view: self.view)
                }
            }
        }
    }

    @objc func nextStageButtonDidClicked(_ sender: UIButton) {
        // DB idx가 1부터 시작하므로 1 더한 값을 전달
        UserDefaults.standard.setValue(index + 1, forKey: Strings.userDefaultStageOneResult)
        let vc = TestConceptSecondViewController(firstIdx: index + 1)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

import UIKit

class TestConceptThirdViewController: BaseViewController {
    private let dataManager: TestThirdDataManager = TestThirdDataManager()
    private var adapter: TestConceptThird?
    private var circularProgressBar: CircularProgressBar?
    private var secondIdx: Int = -1
    private var firstIdx: Int = 0
    private var menu: ConceptFirstMenu?
    private var data: TestDummy?
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataManager.getTest { result in
            self.data = result
            self.adapter = TestConceptThird(of: self.collectionView, data: result) { idx in
                switch idx {
                case -1:
                    self.menu?.nextButton.removeFromSuperview()
                    self.secondIdx = -1
                default:
                    self.menu?.setButton(view: self.view)
                    self.secondIdx = idx - 1
                }
            }
        }
        menu = ConceptFirstMenu()
        menu?.nextButton.setTitle("다음", for: .normal)
        menu?.nextButton.addTarget(self, action: #selector(nextStageButtonDidClicked(_:)), for: .touchDown)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "컨셉 추천 받기"
        circularProgressBar = self.tabBarController?.circularProgressBar(duration: 0.6, progress: 3/3+0.1)
        self.view.addSubview(circularProgressBar!)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        circularProgressBar?.removeFromSuperview()
    }
    
    @objc func nextStageButtonDidClicked(_ sender: UIButton) {
        let vc = TestConceptResultViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

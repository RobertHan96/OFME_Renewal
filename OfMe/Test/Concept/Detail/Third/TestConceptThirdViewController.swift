import UIKit

class TestConceptThirdViewController: BaseViewController {
    private var adapter: TestConceptThirdAdapter?
    private var secondIdx: Int = -1
    private var firstIdx: Int = 0
    private var menu: NextConceptButtonView?
    private var data: TestDummy?
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menu = NextConceptButtonView()
        setupUI()
        
        TestThirdDataManager().getTest { result in
            self.data = result
            self.adapter = TestConceptThirdAdapter(of: self.collectionView, data: result) { idx in
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
    }
    
    private func setupUI() {
        self.navigationItem.title = "컨셉 추천 테스트"
        menu?.nextButton.setTitle("다음", for: .normal)
        menu?.nextButton.addTarget(self, action: #selector(nextStageButtonDidClicked(_:)), for: .touchDown)
    }
    
    @objc func nextStageButtonDidClicked(_ sender: UIButton) {
        let vc = TestConceptResultViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

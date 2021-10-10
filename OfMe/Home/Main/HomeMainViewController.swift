import UIKit
import SideMenu

class HomeMainViewController: BaseViewController {
    @IBOutlet weak var homeMainTableView: UITableView!
    @IBOutlet weak var characterActionButton: UIButton!
    private var userConcept: HomeMainResult? { didSet {
        homeMainTableView.reloadData()
    }}
    private var isEmptyChracter: Bool = false
    private let finishView = FinishSubView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchData(isInit: true, actionIndexPath: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        fetchData(isInit: true, actionIndexPath: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
        finishView.removeView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // 사이드액션바 닫을때 색깔 원복 필요
    @IBAction func characterActionsBtnClicked(_ sender: UIButton) {
        let vc = SideActionsViewController()
        vc.deleagte = self
        let sideMenu = SideMenuNavigationController(rootViewController: vc)
        sideMenu.menuWidth = self.view.frame.width * 0.65
        sideMenu.presentationStyle = .menuDissolveIn
        self.show(sideMenu, sender: nil)

    }
    
    private func fetchData(isInit: Bool, actionIndexPath: Int?) {
        if isInit {
            HomeMainDataManager().getMainHomeData(actionIndex: Action.defaultActionIndexPath) { data in
                self.userConcept = data
            }
            return
        }
        HomeMainDataManager().getMainHomeData(actionIndex: actionIndexPath ?? Action.defaultActionIndexPath) { data in
            self.userConcept = data
        }
    }
    
    private func setupUI() {
        homeMainTableView.estimatedRowHeight = 700
        homeMainTableView.rowHeight = UITableView.automaticDimension
        setupTableView()
    }
    
    private func setupTableView() {
        homeMainTableView.delegate = self
        homeMainTableView.dataSource = self
        homeMainTableView.backgroundColor = .clear
        homeMainTableView.register(UINib.init(nibName: CellManager.TimeInfoCellName, bundle: nil), forCellReuseIdentifier: CellManager.TimeInfoCellIdentifier)
        homeMainTableView.register(UINib.init(nibName: CellManager.CharacterCellName, bundle: nil), forCellReuseIdentifier: CellManager.CharacterCellIdentifier)
        homeMainTableView.register(UINib.init(nibName: CellManager.CharacterInfoCellName, bundle: nil), forCellReuseIdentifier: CellManager.CharacterInfoCellIdentifier)
        homeMainTableView.register(UINib.init(nibName: CellManager.CharacterFeatureCellName, bundle: nil), forCellReuseIdentifier: CellManager.CharacterFeatureCellIdentifier)
        homeMainTableView.register(UINib.init(nibName: CellManager.ConceptSugesstionCellName, bundle: nil), forCellReuseIdentifier: CellManager.ConceptSugesstionCellIdentifier)
    }
}

extension HomeMainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 52
        case 1:
            return 400
        default:
            return 230
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0: // 시간 정보 표시 Cell
            guard let timeInfocell = homeMainTableView.dequeueReusableCell(withIdentifier: CellManager.TimeInfoCellIdentifier) as? TimeInfoCell else { return UITableViewCell() }
            timeInfocell.delegate = self
            timeInfocell.configure(name: userConcept?.nickname, time: userConcept?.clientTime)
            
            return timeInfocell
        case 1: // 캐릭터 이미지 표시 Cell
            guard let characterImagecell = homeMainTableView.dequeueReusableCell(withIdentifier: CellManager.CharacterCellIdentifier) as? CharacterCell else{ return UITableViewCell() }
            characterImagecell.confgirue(imageUrl: userConcept?.image?.first ?? "")
            
            return characterImagecell
        default: // 컨셉 진행 여부에 따라 -> 컨셉 테스트 시작 or 캐릭터 특성 표시 Cell
            if userConcept?.data == nil  {
                characterActionButton.isHidden = true
                return getBottomCellWithEmptyConcept()
            } else {
                characterActionButton.isHidden = false
                return getBottomCellWithConcept(userConcept: userConcept)
            }
        }
    }
}

extension HomeMainViewController: TimeInfoCellDelegate, ConceptSugesstionCellDelegate {
    func endButtonDidCliikd() {
        finishView.setConstraint(view: self.view)
        finishView.confirmButton?.addTarget(self, action: #selector(finishConceptButtonDidClicked), for: .touchDown)
    }
    
    func conceptSugesstionButtonDidClicked() {
        self.navigationController?.pushViewController(TestConceptMainViewController(), animated: true)
    }
    
    @objc func finishConceptButtonDidClicked() {
        pushToFinishViewController()
    }
    
    private func pushToFinishViewController() {
        FinishDataManager().patchFinish { finishData in
            if finishData.code == 1000 {
                let vc = HomeFinishViewController(finishData: finishData.result ?? DummyData.finishEndData)
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                self.presentAlert(title: Strings.PatchFinishEndDataFaildAlert)
            }
        }
    }
}

extension HomeMainViewController: SideActionMenuDelegate {
    func actionButtonDidCliikd(actionIndexPath: Int) {
        fetchData(isInit: false, actionIndexPath: actionIndexPath)
    }
}

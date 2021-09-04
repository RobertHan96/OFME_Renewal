import UIKit
import SideMenu
import Instructions

class HomeMainViewController: BaseViewController {
    @IBOutlet weak var homeMainTableView: UITableView!
    @IBOutlet weak var characterActionButton: UIButton!
    private let coachMarksController = CoachMarksController()
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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.coachMarksController.stop(immediately: true)
    }
        
    @IBAction func characterActionsBtnClicked(_ sender: UIButton) {
        let vc = SideActionsViewController()
        vc.deleagte = self
        let sideMenu = SideMenuNavigationController(rootViewController: vc)
        sideMenu.leftSide = false
        sideMenu.statusBarEndAlpha = 0
        sideMenu.presentationStyle.backgroundColor = .clear
        sideMenu.presentationStyle = .menuDissolveIn
        self.show(sideMenu, sender: nil)
    }
    
    private func fetchData(isInit: Bool, actionIndexPath: Int?) {
        if isInit {
            HomeMainDataManager().getMainHomeData(actionIndex: Action.defaultActionIndexPath) { data in
                self.userConcept = data
                self.setCoachMark(isFirstCharacter: self.userConcept?.data?.isFirstMain?.getBoolFromOX)
            }
            return
        }
        HomeMainDataManager().getMainHomeData(actionIndex: actionIndexPath ?? Action.defaultActionIndexPath) { data in
            self.userConcept = data
        }
    }
    
    private func setCoachMark(isFirstCharacter: Bool?) {
        if isFirstCharacter ?? false {
            self.coachMarksController.start(in: .window(over: self))
        }
    }

    private func setupUI() {
        setupTableView()
        coachMarksController.overlay.backgroundColor = .clear
        coachMarksController.overlay.blurEffectStyle = .none
        coachMarksController.overlay.isUserInteractionEnabled = true
        self.coachMarksController.dataSource = self
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
            if isEmptyChracter {
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
        self.navigationController?.pushViewController(TestMainViewController(), animated: true)
    }
    
    @objc func finishConceptButtonDidClicked() {
        pushToFinishViewController()
    }
    
    private func pushToFinishViewController() {
        FinishDataManager().patchFinish { finishData in
            if finishData.code == 1000 {
                self.navigationController?.pushViewController(
                    HomeFinishViewController(finishData: finishData.result ?? DummyData.finishEndData),
                    animated: true)
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

extension HomeMainViewController:  CoachMarksControllerDataSource, CoachMarksControllerDelegate {
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkViewsAt index: Int, madeFrom coachMark: CoachMark) -> (bodyView: (UIView & CoachMarkBodyView), arrowView: (UIView & CoachMarkArrowView)?) {
        let coachView = coachMarksController.helper.makeDefaultCoachViews(hintText: "액션을 적용하면 재미가 두배")
        coachView.bodyView.background.cornerRadius = 1
        coachView.bodyView.hintLabel.font = UIFont.Notos(.regular, size: 12)

        return (bodyView: coachView.bodyView, arrowView: coachView.arrowView)
    }
    
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkAt index: Int) -> CoachMark {
        return coachMarksController.helper.makeCoachMark(for: self.characterActionButton)
    }
    
    func numberOfCoachMarks(for coachMarksController: CoachMarksController) -> Int {
        return 1
    }
}

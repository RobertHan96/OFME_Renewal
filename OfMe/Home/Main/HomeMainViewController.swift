import UIKit
import SideMenu
import Kingfisher

class HomeMainViewController: BaseViewController {
    
    @IBOutlet weak var homeMainTableView: UITableView!
    @IBOutlet weak var characterActions: UIButton!
    private var userConcept: HomeMainResult? { didSet {
        homeMainTableView.reloadData()
    }}
    private var isEmptyChracter: Bool = false
    
    // 이전 개발자가 짠 코드
    private var tapImages: [String] = []
    private var data: [CharacterResult] = []
    private var actionData: [CharacterAction] = []
    private var startTime: Date = Date()
    private var timer: Timer = Timer()
    private var time: Int = 0
    private var stopTimer: Timer = Timer()
    private var customView: HomeCustom = HomeCustom()
    private let finishView = FinishSubView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        HomeMainDataManager().getMainHomeData { data in
            // 코치마크 화면 출력
            self.userConcept = data
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.middleButton?.removeFromSuperview()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        middleButton?.removeFromSuperview()
        self.view.removeFromSuperview()
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
    
    private func setupUI() {
        // 1. API 호출 -> response code & reuslt? 반환 -> response code를 기준으로 진행 중 / 미진행 UI 분기
        // dataManager.get() { code, result in
        // switch code 1001 -> setEmptyCharacterView & isEmptyChracter = true
        //             default -> setCharacterView & isEmptyChracter = false
        // }
        setupTableView()
    }
    
    // Delegate에서 처음 유저인지 여부를 판단해서 다르게 테이블뷰 생성
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
    
    func setTimer(startTime: Date) {
        self.timer.invalidate()
        DispatchQueue.main.async { [weak self] in
            self?.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
                UserDefaults.standard.setValue(self!.time, forKey: "time")
                let startSec = Int(Date().timeIntervalSince(startTime)) + self!.time * 60
                var diffMin = startSec / 60
                let diffHour = diffMin / 60
                diffMin = diffMin % 60
                self?.customView.timeLabel?.text = "\(diffHour > 0 ? "\(diffHour)시간 \(diffMin)분" : "\(diffMin)분")"
            }
        }
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
            
            // 메인 API 반환 Data를 매번 configrue 함수에 전달
            let name = userConcept?.nickname
//            let time = nil : 추후 메인 API에서 내려주는 시간 정보값 할당
            timeInfocell.configure(name: name, time: "500")
            return timeInfocell
            
        case 1: // 캐릭터 이미지 표시 Cell
            guard let characterImagecell = homeMainTableView.dequeueReusableCell(withIdentifier: CellManager.CharacterCellIdentifier) as? CharacterCell else{ return UITableViewCell() }
            characterImagecell.confgirue(imageUrl: userConcept?.image?.first ?? "")
            return characterImagecell
            
        default: // 컨셉 진행 여부에 따라 -> 컨셉 테스트 시작 or 캐릭터 특성 표시 Cell
            if isEmptyChracter {
                characterActions.isHidden = true
                return getBottomCellWithEmptyConcept()
            } else {
                characterActions.isHidden = false
                return getBottomCellWithConcept(userConcept: userConcept)
            }
        }
    }
}

extension HomeMainViewController: TimeInfoCellDelegate, ConceptSugesstionCellDelegate {
    func endButtonDidCliikd() {
        print("캐릭터 컨셉이 종료되었습니다. + API 호출")
    }
    
    func conceptSugesstionButtonDidClicked() {
        print("컨셉 테스트 화면으로 이동 + API 호출")
    }
}

extension HomeMainViewController: SideActionMenuDelegate {
    func actionButtonDidCliikd(actionIndexPath: Int) {
        let actionName = Action().getActionNameFromIndexPath(indexPath: actionIndexPath)
        print("LOG: 동작 \(actionName) 눌림")
        HomeMainDataManager().getMainHomeData(actionIndex: actionIndexPath) { data in
            self.userConcept = data
        }
    }
    
    func setCharacterImageByAction() {
        
    }
}

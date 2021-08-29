import UIKit
import Kingfisher


// 컨셉 없는 상태 : 액션 버튼, TimeInfoCell 정보 없애기
// Cell 버튼, 폰트 디자인 변경
// 컨셉 추천받기 Delegate 액션

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
            return timeInfocell
        case 1: // 캐릭터 이미지 표시 Cell
            guard let characterImagecell = homeMainTableView.dequeueReusableCell(withIdentifier: CellManager.CharacterCellIdentifier) as? CharacterCell else{ return UITableViewCell() }
            return characterImagecell
        default: // 컨셉 진행 여부에 따라 -> 컨셉 테스트 시작 or 캐릭터 특성 표시 Cell
            return getBottomCell(isEmptyCharacter: isEmptyChracter, userConcept: userConcept) { cell in
                if self.userConcept != nil {
                    print("LOG - 유저가 진행 중인 컨셉 있음")
                } else {
                    print("LOG - 유저가 진행 중인 컨셉 없음")
                }
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

class HomeMainViewController: BaseViewController {
    
    @IBOutlet weak var homeMainTableView: UITableView!
    
    private var userConcept: HomeMainResult?
    private var isEmptyChracter: Bool = true { didSet {
        homeMainTableView.reloadData()
    }}
    
    // 이전 개발자가 짠 코드
    private var stopImage: String = ""
    private let dataManager = HomeMainDataManager()
    private var tapImages: [String] = []
    private var data: [CharacterResult] = []
    private var actionData: [CharacterAction] = []
    private var startTime: Date = Date()
    private var timer: Timer = Timer()
    private var time: Int = 0
    private var stopTimer: Timer = Timer()
    private var actionAdapter: ActionAdapter = ActionAdapter()
    private var customView: HomeCustom = HomeCustom()
    private let finishView = FinishSubView()
    private var isPlay: Bool = true
    private var isFirst: Bool = false
    private var isFirstTime: Bool = false
    private var isTap: Bool = false
    private var preview: PreviewAdapter?
    private var idx: Int = 5
    private lazy var bubbleImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImgName.imgName(of: .bubble))
        return imageView
    }()
    private lazy var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .Notos(.regular, size: 12)
        label.textColor = .gray3
        label.text = "오늘의 친구를 만나보세요"
        return label
    }()

    @IBOutlet weak var backgroundImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        HomeMainDataManager().getMainHomeData { data in
            print("LOGT:",data)
        }
        
//        preview = PreviewAdapter { button in
//            switch button.tag {
//            case 0:
//                self.preview?.backgroundView.removeFromSuperview()
//                self.preview?.view.removeFromSuperview()
//            case 1:
//                let vc = TestMainViewController()
//                self.navigationController?.pushViewController(vc, animated: true)
//            default:
//                let vc = TestConceptMainViewController()
//                self.navigationController?.pushViewController(vc, animated: true)
//            }
//        }
//        customView.infoButton.addTarget(self, action: #selector(infoTouchDown(_:)), for: .touchDown)
//        changeIsFirst()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.middleButton?.removeFromSuperview()
        if !data.isEmpty {
            self.middleButton = self.tabBarController?.endMiddleButton()
        } else {
            self.middleButton = self.tabBarController?.testMiddleButton()
        }
        self.middleButton?.addTarget(self, action: #selector(self.middleTouchDown(_:)), for: .touchDown)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        middleButton?.removeFromSuperview()
        self.view.removeFromSuperview()
        dataManager.patchCharacterTime(time: time)
    }
    
    // Main API response코드에 따라서, 캐릭터 진행 중 / 미진행에 맞는 UI 렌더링
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
    
    func setFirst() {
        bubbleImage.image = UIImage(named: ImgName.imgName(of: .bubble))
        label.text = "오늘의 친구를 만나보세요"
        self.view.addSubview(bubbleImage)
        bubbleImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(self.view.frame.height*0.48)
            make.left.equalToSuperview().inset(self.view.frame.width*0.14)
        }
        bubbleImage.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview().inset(-30)
            make.left.right.equalToSuperview().inset(15)
        }
    }
    
    func setStop() {
        bubbleImage.image = UIImage(named: ImgName.imgName(of: .bubbleRight))
        label.text = "나 여기 있어..!"
        self.view.addSubview(bubbleImage)
        bubbleImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(self.view.frame.height*0.6)
            make.left.equalToSuperview().inset(self.view.frame.width*0.37)
        }
        bubbleImage.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview().inset(-30)
            make.left.right.equalToSuperview().inset(15)
        }
    }
    
    func changeIsFirst() {
        self.timer.invalidate()
        [self.bubbleImage, self.label].forEach { $0?.removeFromSuperview() }
        [customView.changeButton,customView.charactorImageView,customView.infoButton,customView.menu].forEach {
            $0.removeFromSuperview()
        }
        startTime = Date()
        dataManager.getCharacter { result in
            print(result)
            self.data = result
            self.middleButton?.removeFromSuperview()
            if let data = result.last, data.name != nil {
                self.time = result.last!.timer!
                self.middleButton = self.tabBarController?.endMiddleButton()
                [self.bubbleImage, self.label].forEach { $0?.removeFromSuperview() }
                self.customView.setConstraint(view: self.view)
                self.customView.timeButton?.addTarget(self, action: #selector(self.timerTouchDown(_:)), for: .touchDown)
                self.customView.changeButton.addTarget(self, action: #selector(self.changeTouchDown(_:)), for: .touchDown)
                let screen = UIScreen.main.bounds.width
                if let url = URL(string: result.last!.url!) {
                    self.customView.charactorImageView.kf.setImage(with: url)
                    self.customView.charactorImageView.snp.makeConstraints { make in
                        make.width.equalTo(152*screen/375)
                        make.height.equalTo(325*screen/375)
                    }
                }
                self.customView.titleLabel?.text = "\(result.last!.nickname)과 \(result.last!.name!)과 함께한지"
                self.setTimer(startTime: self.startTime)
                self.isFirst = true
                self.middleButton?.addTarget(self, action: #selector(self.middleTouchDown(_:)), for: .touchDown)
            } else {
                self.middleButton = self.tabBarController?.testMiddleButton()
                self.middleButton?.addTarget(self, action: #selector(self.middleTouchDown(_:)), for: .touchDown)
                self.setFirst()
                self.isFirst = false
            }
        }
        dataManager.getCharacterAction { result in
            self.actionData = result
        }
    }
    
    func setCharactor(idx: Int) {
        customView.changeButton.setImage(UIImage(named: ImgName.imgName(of: .moon)), for: .normal)
        backgroundImageView.image = UIImage(named: ImgName.imgName(of: .background))
        customView.charactorImageView.image = nil
        customView.charactorImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
        self.customView.charactorImageView.addGestureRecognizer(tapGesture)
        let screen = UIScreen.main.bounds.width
        if !actionData.isEmpty {
            customView.charactorImageView.image = nil
            switch idx {
            case 0:
                customView.charactorImageView.isHidden = true
                self.customView.charactorImageView.snp.remakeConstraints { make in
                    make.bottom.equalToSuperview().inset(80)
                    make.centerX.equalToSuperview()
                    make.width.equalTo(152*screen/375)
                    make.height.equalTo(325*screen/375)
                }
                customView.charactorImageView.isHidden = false
                let images = actionData.filter { return $0.situation.contains("water") }
                tapImages = [images[0].url, images[1].url]
                customView.charactorImageView.kf.setImage(with: URL(string: images[0].url))
            case 1:
                customView.charactorImageView.isHidden = true
                self.customView.charactorImageView.snp.remakeConstraints { make in
                    make.bottom.equalToSuperview().inset(80)
                    make.centerX.equalToSuperview()
                    make.width.equalTo(325*screen/375)
                    make.height.equalTo(152*screen/375)
                }
                customView.charactorImageView.isHidden = false
                let images = actionData.filter { return $0.situation.contains("sleep") }
                tapImages = [images[0].url, images[1].url]
                customView.charactorImageView.kf.setImage(with: URL(string: images[0].url))
            case 2:
                customView.charactorImageView.isHidden = true
                self.customView.charactorImageView.snp.remakeConstraints { make in
                    make.bottom.equalToSuperview().inset(80)
                    make.centerX.equalToSuperview()
                    make.width.equalTo(152*screen/375)
                    make.height.equalTo(325*screen/375)
                }
                customView.charactorImageView.isHidden = false
                customView.changeButton.setImage(UIImage(named: ImgName.imgName(of: .sunButton)), for: .normal)
                backgroundImageView.image = UIImage(named: ImgName.imgName(of: .backgroundSun))
                let images = actionData.filter { return $0.situation.contains("sun") }
                tapImages = [images[0].url, images[1].url]
                customView.charactorImageView.kf.setImage(with: URL(string: images[0].url))
            case 3:
                customView.charactorImageView.isHidden = true
                self.customView.charactorImageView.snp.remakeConstraints { make in
                    make.bottom.equalToSuperview().inset(80)
                    make.centerX.equalToSuperview()
                    make.width.equalTo(277*screen/375)
                    make.height.equalTo(375*screen/375)
                }
                customView.charactorImageView.isHidden = false
                let images = actionData.filter { return $0.situation.contains("tv") }
                tapImages = [images[0].url, images[1].url]
                customView.charactorImageView.kf.setImage(with: URL(string: images[0].url))
            case 4:
                customView.charactorImageView.isHidden = true
                self.customView.charactorImageView.snp.remakeConstraints { make in
                    make.bottom.equalToSuperview().inset(80)
                    make.centerX.equalToSuperview()
                    make.width.equalTo(305*screen/375)
                    make.height.equalTo(328*screen/375)
                }
                customView.charactorImageView.isHidden = false
                let images = actionData.filter { return $0.situation.contains("reverse") }
                tapImages = [images[0].url, images[1].url]
                customView.charactorImageView.kf.setImage(with: URL(string: images[0].url))
            default:
                customView.charactorImageView.isHidden = true
                self.customView.charactorImageView.snp.remakeConstraints { make in
                    make.bottom.equalToSuperview().inset(80)
                    make.centerX.equalToSuperview()
                    make.width.equalTo(152*screen/375)
                    make.height.equalTo(325*screen/375)
                }
                customView.charactorImageView.isHidden = false
                let images = actionData.filter { return $0.situation.contains("default") }
                tapImages = [images[0].url, images[1].url]
                customView.charactorImageView.kf.setImage(with: URL(string: images[0].url))
            }
        }
    }
    
    @objc func tapGesture() {
        if isTap {
            customView.charactorImageView.kf.setImage(with: URL(string: tapImages[1]))
        } else {
            customView.charactorImageView.kf.setImage(with: URL(string: tapImages[0]))
        }
        isTap = !isTap
    }
    
    @objc func timerTouchDown(_ sender: UIButton) {
        if isPlay {
            customView.changeButton.isUserInteractionEnabled = false
            customView.charactorImageView.isUserInteractionEnabled = false
            timer.invalidate()
            time = Int(Date().timeIntervalSince(startTime)) / 60
            dataManager.patchCharacterTime(time: time)
            var cnt = 0
            customView.timeButton?.isUserInteractionEnabled = false
            self.customView.charactorImageView.snp.remakeConstraints { make in
                make.bottom.equalToSuperview().inset(80)
                make.centerX.equalToSuperview()
                make.width.equalTo(116)
                make.height.equalTo(325)
            }
            let images = actionData.filter { return $0.situation.contains("stop") }
            self.customView.charactorImageView.kf.setImage(with: URL(string: images[0].url))
            stopTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
                if cnt == 0 {
                    self?.backgroundImageView.image = UIImage(named: ImgName.imgName(of: .backgroundStop))
                    self?.customView.charactorImageView.kf.setImage(with: URL(string: images[0].url))
                } else {
                    self?.backgroundImageView.image = UIImage(named: ImgName.imgName(of: .background))
                    self?.customView.charactorImageView.image = nil
                    self?.setStop()
                    self?.customView.timeButton?.isUserInteractionEnabled = true
                    self?.timer.invalidate()
                    self?.stopTimer.invalidate()
                }
                cnt += 1
            }
        } else {
            timer.invalidate()
            customView.changeButton.isUserInteractionEnabled = true
            [bubbleImage,label].forEach { $0.removeFromSuperview() }
            setCharactor(idx: idx)
            customView.charactorImageView.isUserInteractionEnabled = true
            startTime = Date()
            setTimer(startTime: startTime)
        }
        isPlay = !isPlay
        customView.setButton(customView.timeButton!, isPlay: isPlay)
    }
    
    @objc func infoTouchDown(_ sender: UIButton) {
        var idx: Int
        if let data = data.last {
            idx = data.id!
            let vc = HomeInfoViewController(idx: idx)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func middleTouchDown(_ sender: UIButton) {
        if isFirst {
            finishView.setConstraint(view: self.view)
            finishView.confirmButton?.addTarget(self, action: #selector(finishTouchDown), for: .touchDown)
        } else {
            if let preview = preview {
                self.view.addSubview(preview.backgroundView)
                self.view.addSubview(preview.view)
            }
        }
    }
    
    @objc func finishTouchDown() {
        if let data = data.last {
            finishView.mainView.removeFromSuperview()
            let time = (Int(Date().timeIntervalSince(startTime)) + self.time * 60) / 60
            let vc = HomeFinishViewController(data: data, time: time)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func changeTouchDown(_ sender: UIButton) {
        actionAdapter.setConstraint(view: self.view)
        actionAdapter.applyButton?.addTarget(self, action: #selector(applyTouchDown(_:)), for: .touchDown)
    }
    
    @objc func applyTouchDown(_ sender: UIButton) {
        actionAdapter.menuView.removeFromSuperview()
        idx = sender.tag
        setCharactor(idx: idx)
    }
}

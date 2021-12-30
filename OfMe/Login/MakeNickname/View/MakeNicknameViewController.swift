import UIKit
import RxCocoa
import RxSwift
import Alamofire

class MakeNicknameViewController: BaseViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nicknameTextFeild: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var clearTextButton: UIButton!
    @IBOutlet weak var checkDuplecatedNicknameButton: UIButton!
    @IBOutlet weak var nicknameStatusLabel: UILabel!
    let enabledBtnBackgroundImage = UIImage(named: "next_btn_background-1")
    let disposeBag: DisposeBag = DisposeBag()
    let viewModel: MakeNicknameViewModel = MakeNicknameViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // hideNavigationBar로 함수화
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        hideNavigationBar()
    }
    
    private func setupUI() {
        bindUI()
        self.navigationItem.setHidesBackButton(true, animated: false)
        // 조건 만족시 다음 버튼 isEnabled = True로 변경 필요
        nicknameStatusLabel.isHidden = true
        nextButton.isEnabled = false
        clearTextButton.isHidden = true
        checkDuplecatedNicknameButton.isHidden = true
        nextButton.backgroundColor = .nicknameTextFieldColor
        checkDuplecatedNicknameButton.titleLabel?.textColor = .typoBlue
        nicknameStatusLabel.textAlignment = .center
    }
    
    private func hideNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func bindUI() {
        viewModel.isDuplecatedNickname
            .asObservable()
            .subscribe { isDuplecatedNicknameResult in
                // Main 스레드에서 돌아가야할 것 같은데 Rx 메소드 조사 필요
                if isDuplecatedNicknameResult {
                    self.nicknameStatusLabel.attributedText = self.viewModel.infromMessage.value
                    self.nicknameStatusLabel.isHidden = false
                    self.nicknameStatusLabel.textColor = .nicknameDuplecatedWaringColor
                } else {
                    self.nicknameStatusLabel.attributedText = self.viewModel.infromMessage.value
                    self.nextButton.isEnabled = true
                    self.nextButton.backgroundColor = .typoBlue
                    self.nicknameStatusLabel.isHidden = false
                    self.nicknameStatusLabel.textColor = .typoBlue
                }
            }.disposed(by: disposeBag)

        // 1000이면 다음, 아니면 에러 팝업 표시 : rx문서 더 찾아봐야함
//        self.presentBottomAlert(message: "닉네임 생성 실패 - code(\(makeNicknameResponse.code))")
//        viewModel.nicknameMakingResult
//            .subscribe {  in
//                self.presentBottomAlert(message: "닉네임 생성 실패 - code(\(makeNicknameResponse.code))")
//            } onError: { <#Error#> in
//                <#code#>
//            } onCompleted: {
//                <#code#>
//            } onDisposed: {
//                <#code#>
//            }

        
        nicknameTextFeild.rx.text.orEmpty
            .map { _ in self.isValidNickname() }
            .subscribe { str in
                print(str)
            } onError: { err in
                print(err)
            }.disposed(by: disposeBag)
    }
    
    private func isValidNickname() -> Bool {
        if viewModel.checkNicknamePolicy() {
            self.checkDuplecatedNicknameButton.isHidden = false
            self.clearTextButton.isHidden = false
        } else {
            self.checkDuplecatedNicknameButton.isHidden = true
            self.clearTextButton.isHidden = true
        }
    }
    
    // viewModel에 있는 UI 관련 로직들이 다시 일로 와야함
    @IBAction func checkDuplecatedNicknameButtonDidClicked(_ sender: UIButton) {
        viewModel.checkDuplecatedNickname()
    }
    
    // viewModel에 있는 UI 관련 로직들이 다시 일로 와야함
    @IBAction func nextButtonDidkClicked(_ sender: UIButton) {
        viewModel.makeNickname(nickname: nicknameTextFeild.text ?? "")
    }

    @IBAction func clearTextButtonDidClicked(_ sender: UIButton) {
        nicknameTextFeild.text = nil
        nicknameStatusLabel.isHidden = true
    }
    
}

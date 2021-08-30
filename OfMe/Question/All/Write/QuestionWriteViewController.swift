import UIKit
import Alamofire

class QuestionWriteViewController: BaseViewController {
    private let subView = QuestionAllSubView()
    private var isEdit: Bool = false
    private var idx: Int = 0
    private var answer = ""
    private let dataManager = QuestionWriteDataManager()
    private var data: SubAllQuestion = SubAllQuestion(id: 0, sort: "", question: "", share: "")
    private var questionData: [QuestionGet] = []
    private var isShare: Bool = false
    
    lazy var rightButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.tintColor = .label
        button.title = "등록"
        button.setTitleTextAttributes([
            .font : UIFont.Notos(.bold, size: 14),
            .foregroundColor : UIColor.mainBlue
        ], for: .normal)
        button.isEnabled = false
        button.target = self
        button.action = #selector(submit)
        return button
    }()
    
    @IBOutlet weak var warnLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var textField4: UITextField!
    @IBOutlet weak var textField5: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var removeButton: UIButton!
    
    init(id: Int,data: SubAllQuestion, isEdit: Bool) {
        super.init(nibName: "QuestionWriteViewController", bundle: Bundle.main)
        self.isEdit = isEdit
        self.data = data
        self.idx = id
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        removeButton.isHidden = true
        
        self.navigationItem.rightBarButtonItem = rightButton
        
        dataManager.getQuestion(idx: idx) {
            self.questionData = $0
            if !self.questionData.isEmpty {
                self.isShare = $0.first!.share == "Y" ? true : false
                if self.isShare {
                    self.nextButton.backgroundColor = #colorLiteral(red: 0.9564632773, green: 0.9601823688, blue: 1, alpha: 1)
                    self.nextButton.setAttributedTitle(NSAttributedString(string: "공유하기",
                                                                     attributes: [
                                                                        .font : UIFont.Notos(.regular, size: 12),
                                                                        .foregroundColor : UIColor(hex: 0x7d85d3)
                                                                     ]), for: .normal)
                } else {
                    self.nextButton.backgroundColor = #colorLiteral(red: 0.9803065658, green: 0.9804469943, blue: 0.9802758098, alpha: 1)
                    self.nextButton.setAttributedTitle(NSAttributedString(string: "공유하기",
                                                                     attributes: [
                                                                        .font : UIFont.Notos(.regular, size: 12),
                                                                        .foregroundColor : UIColor.gray3
                                                                     ]), for: .normal)
                }
                self.removeButton.isHidden = false
                self.answer = self.questionData.first!.answer
                self.questionData.first!.answer.components(separatedBy: " ").enumerated().forEach {
                    switch $0.offset {
                    case 0:
                        self.textField1.text = $0.element
                    case 1:
                        self.textField2.text = $0.element
                    case 2:
                        self.textField3.text = $0.element
                    case 3:
                        self.textField4.text = $0.element
                    default:
                        self.textField5.text = $0.element
                    }
                }
                if self.isEdit {
                    self.warnLabel.isHidden = false
                    self.rightButton.title = "수정"
                    self.navigationItem.rightBarButtonItem = self.rightButton
                    [self.removeButton, self.nextButton].forEach { $0?.isHidden = false }
                    [self.textField1,self.textField2,self.textField3,self.textField4,self.textField5].forEach { $0?.isUserInteractionEnabled = true }
                } else {
                    self.warnLabel.isHidden = true
                    self.navigationItem.rightBarButtonItem = nil
                    [self.removeButton, self.nextButton].forEach { $0?.isHidden = true }
                    [self.textField1,self.textField2,self.textField3,self.textField4,self.textField5].forEach { $0?.isUserInteractionEnabled = false }
                }
            }
        }
        
        titleLabel.font = .Notos(.bold, size: 17)
        titleLabel.textColor = .mainBlue
        titleLabel.text = data.question
        [textField1, textField2, textField3, textField4, textField5].forEach {
            $0?.text = nil
            $0?.font = .Notos(.regular, size:12)
            $0?.delegate = self
            $0?.borderStyle = .none
            let border = CALayer()
            border.frame = CGRect(x: 0, y: $0!.frame.size.height-1, width: $0!.frame.width-12, height: 1)
            border.backgroundColor = UIColor.init(hex: 0xEDEDED).cgColor
            $0?.layer.addSublayer((border))
        }
        
        nextButton.setAttributedTitle(NSAttributedString(string: "공유하기",
                                                         attributes: [
                                                            .font : UIFont.Notos(.regular, size: 12),
                                                            .foregroundColor : UIColor.gray3
                                                         ]), for: .normal)
        nextButton.backgroundColor = #colorLiteral(red: 0.9803065658, green: 0.9804469943, blue: 0.9802758098, alpha: 1)
        nextButton.addTarget(self, action: #selector(nextTouchDown(_:)), for: .touchDown)
        
        removeButton.addTarget(self, action: #selector(removeTouchDown(_:)), for: .touchDown)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "답변 작성"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        middleButton?.removeFromSuperview()
    }
    
    @objc func nextTouchDown(_ sender: UIButton) {
        if isShare {
            self.nextButton.backgroundColor = #colorLiteral(red: 0.9803065658, green: 0.9804469943, blue: 0.9802758098, alpha: 1)
            self.nextButton.setAttributedTitle(NSAttributedString(string: "공유하기",
                                                             attributes: [
                                                                .font : UIFont.Notos(.regular, size: 12),
                                                                .foregroundColor : UIColor.gray3
                                                             ]), for: .normal)
        } else {
            self.nextButton.backgroundColor = #colorLiteral(red: 0.9564632773, green: 0.9601823688, blue: 1, alpha: 1)
            self.nextButton.setAttributedTitle(NSAttributedString(string: "공유하기",
                                                             attributes: [
                                                                .font : UIFont.Notos(.regular, size: 12),
                                                                .foregroundColor : UIColor(hex: 0x7d85d3)
                                                             ]), for: .normal)
        }
        isShare = !isShare
        rightButton.isEnabled = true
    }
    
    @objc func removeTouchDown(_ sender: UIButton) {
        dataManager.delete(idx: idx) {
            if $0 != 1000 { self.presentAlert(title: "다시 시도해 주시기 바랍니다.") }
            else { self.navigationController?.popViewController(animated: true) }
        }
    }
    
    @objc func submit() {
        let method: HTTPMethod = isEdit ? .patch : .post
        dataManager.writeQuestion(idx: idx, text: answer, isShare: isShare, method: method) {
            if $0 != 1000 { self.presentAlert(title: "다시 시도해 주시기 바랍니다.") }
            else {
                if method == .post {
                    if self.isShare {
                        self.subView.setSendConstraint(view: self.view)
                        self.subView.end?.addTarget(self, action: #selector(self.end), for: .touchDown)
                        self.subView.button?.addTarget(self, action: #selector(self.touchDown), for: .touchDown)
                    } else {
                        self.navigationController?.popViewController(animated: true)
                    }
                } else {
                    self.navigationController?.popViewController(animated: true)
                }
    
            }
        }
    }
    
    @objc func end() {
        self.navigationController?.popViewController(animated: true)
        self.tabBarController?.selectedIndex = 3
    }
    
    @objc func touchDown() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension QuestionWriteViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        answer = ""
        [textField1,textField2,textField3,textField4,textField5].forEach {
            if let text = $0?.text {
                answer += text.trimmingCharacters(in: .whitespacesAndNewlines) + "\n"
            }
        }
        answer = answer.trimmingCharacters(in: .whitespacesAndNewlines)
        if answer.isEmpty {
            rightButton.isEnabled = false
        } else {
            rightButton.isEnabled = true
        }
    }
    
    func checkTextField() -> Bool {
        var flag: Bool = false
        [textField1, textField2, textField3, textField4, textField5].forEach {
            if let text = $0?.text {
                if text.trimmingCharacters(in: .whitespacesAndNewlines).isExists {
                    flag = true
                }
            }
        }
        return flag
    }
}

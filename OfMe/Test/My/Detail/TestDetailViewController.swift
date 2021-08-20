import UIKit

class TestDetailViewController: BaseViewController {
    private var dataManager: TestMyDetailDataManager = TestMyDetailDataManager()
    private var step: Int = 1
    private var circularProgressBar: CircularProgressBar?
    internal let identifier = "TestDetailViewController"
    private var answer: [Int] = []
    private var answerSheet: [String] = []
    private var highLightText: [String] = DummyData.highlightedSheet
    private var data: [TestMyDetail] = []
    
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var descriptLabel: UILabel!
    @IBOutlet weak var answerFirstButton: UIButton!
    @IBOutlet weak var answerSecondButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    init(step: Int) {
        super.init(nibName: identifier, bundle: Bundle.main)
        self.step = step
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        circularProgressBar = self.tabBarController?.circularProgressBar(duration: 0.6, progress: CGFloat(step)/12)
        setUP()
        self.view.addSubview(circularProgressBar!)
        dataManager.getQuestion { result in
            print(self.step)
            self.data = result
            self.setQuestion(step: Int(self.step))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "나의 성향 알기"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        circularProgressBar?.removeFromSuperview()
    }
    
    @IBAction func firstTouchDown(_ sender: Any) {
        answerSheet[step-1] = data[step-1].sort
        answer[step-1] = 0
        setSelected(button: answerFirstButton, text: data[step-1].ENTPanswer)
        setUnselected(button: answerSecondButton, text: data[step-1].ISFJanswer)
        nextButton.isUserInteractionEnabled = true
        nextButton.alpha = 1
    }
    
    @IBAction func secondTouchDown(_ sender: Any) {
        answerSheet[step-1] = data[step-1].sort
        answer[step-1] = 1
        setSelected(button: answerSecondButton, text: data[step-1].ISFJanswer)
        setUnselected(button: answerFirstButton, text: data[step-1].ENTPanswer)
        nextButton.isUserInteractionEnabled = true
        nextButton.alpha = 1
    }
    
    @IBAction func nextTouchDown(_ sender: Any) {
        if step < 12 {
            step += 1
            setQuestion(step: step)
            circularProgressBar?.removeFromSuperview()
            circularProgressBar = self.tabBarController?.circularProgressBar(duration: 0.6, progress: CGFloat(step)/12+0.1)
            self.view.addSubview(circularProgressBar!)
        } else {
            let vc = TestResultViewController(answer: answer, answerSheet: answerSheet)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func prevTouchDown(_ sender: Any) {
        if step > 1 {
            step -= 1
        }
        setQuestion(step: step)
        circularProgressBar?.removeFromSuperview()
        circularProgressBar = self.tabBarController?.circularProgressBar(duration: 0.6, progress: CGFloat(step)/12+0.1)
        self.view.addSubview(circularProgressBar!)

    }
    
    func setUP() {
        answer = [Int].init(repeating: -1, count: 12)
        answerSheet = [String].init(repeating: "", count: 12)
        stepLabel.font = .Notos(.regular, size: 10)
        stepLabel.textColor = .gray3
        stepLabel.backgroundColor = .white
        stepLabel.text = "\(Int(step)) / 12"
        
        descriptLabel.font = .Notos(.regular, size: 18)
        stepLabel.textColor = .gray2
    }
    
    func setQuestion(step: Int) {
        print(answer[step-1])
        print(step)
        [answerFirstButton, answerSecondButton].forEach { $0?.setTitle(nil, for: .normal) }
        descriptLabel.makeHightledText(all: data[step-1].question, for: data[step-1].highlight)
        stepLabel.text = "\(step) / 12"
        if answer[step-1] != -1 {
            switch answer[step-1] {
            case 0:
                setSelected(button: answerFirstButton, text: data[step-1].ENTPanswer)
                setUnselected(button: answerSecondButton, text: data[step-1].ISFJanswer)
            default:
                setSelected(button: answerSecondButton, text: data[step-1].ISFJanswer)
                setUnselected(button: answerFirstButton, text: data[step-1].ENTPanswer)
            }
            nextButton.isUserInteractionEnabled = true
            nextButton.alpha = 1
        } else {
            nextButton.alpha = 0.4
            nextButton.isUserInteractionEnabled = false
            setUnselected(button: answerFirstButton, text: data[step-1].ENTPanswer)
            setUnselected(button: answerSecondButton, text: data[step-1].ISFJanswer)
        }
        if step == 1 {
            prevButton.isUserInteractionEnabled = false
            prevButton.alpha = 0.4
        } else {
            prevButton.isUserInteractionEnabled = true
            prevButton.alpha = 1
        }
        if step != 12 {
            nextButton.setCustomTitle(text: "다음", font: .Notos(.bold, size: 16), color: .mainBlue)
        } else {
            nextButton.setCustomTitle(text: "완료", font: .Notos(.bold, size: 16), color: .mainBlue)
        }
    }
    
    func setSelected(button: UIButton, text: String) {
        button.backgroundColor = #colorLiteral(red: 0.18759498, green: 0.3460971713, blue: 0.878590703, alpha: 1)
        button.borderColor = #colorLiteral(red: 0.18759498, green: 0.3460971713, blue: 0.878590703, alpha: 1)
        button.setCustomTitle(text: text, font: .Notos(.bold, size: 14), color: .white)
        button.isUserInteractionEnabled = false
    }
    
    func setUnselected(button: UIButton, text: String) {
        button.backgroundColor = .white
        button.borderColor = #colorLiteral(red: 0.9293304086, green: 0.929463923, blue: 0.9293012023, alpha: 1)
        button.setCustomTitle(text: text, font: .Notos(.regular, size: 14), color: .gray2)
        button.isUserInteractionEnabled = true
    }

}

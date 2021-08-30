import UIKit
import ImagePicker

class ArchiveWriteViewController: BaseViewController {
    private var writeDataManager = WriteDataManager()
    private var concept: [WriteConcept] = []
    private var data: [DiaryGet] = []
    private var dataManager = DiaryDataManager()
    private var info: WriteInfo = WriteInfo()
    private var isEdit: Bool = false
    private let pickerView: ArchiveWritePicker = ArchiveWritePicker()
    private var date: Date = Date()
    
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
        button.action = #selector(writeTouchDown)
        return button
    }()
    
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var charactorTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    init(data: DiaryGet) {
        super.init(nibName: "ArchiveWriteViewController", bundle: Bundle.main)
        info = WriteInfo(diaryIdx: data.id, idx: data.conceptId, title: data.title, content: data.content, images: [])
        self.data.append(data)
        isEdit = true
    }
    
    init() {
        super.init(nibName: "ArchiveWriteViewController", bundle: Bundle.main)
    }
    
    init(date: Date) {
        super.init(nibName: "ArchiveWriteViewController", bundle: Bundle.main)
        self.date = date
        writeDataManager.getConcept(date: date) { data in
            self.concept = data
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonText()
        collectionView.frame.size = CGSize(width: UIScreen.main.bounds.width-40, height: 95)
        titleTextField.frame.size = CGSize(width: UIScreen.main.bounds.width-40, height: 35)
        [titleTextField, charactorTextField, collectionView].forEach {
            $0.snp.makeConstraints { make in
                make.width.equalTo(UIScreen.main.bounds.width-40)
            }
        }
        let touch = UITapGestureRecognizer(target: self, action: #selector(singleTapGestureCaptured(gesture:)))
        scrollView.addGestureRecognizer(touch)
        setUnderLine(of: titleTextField)
        setUnderLine(of: charactorTextField)
        titleTextField.font = .Notos(.regular, size: 14)
        charactorTextField.font = .Notos(.bold, size: 14)
        charactorTextField.textColor = .mainBlue
        contentTextView.font = .Notos(.regular, size: 12)
        contentTextView.text = "내용을 입력해주세요."
        contentTextView.textColor = .lightGray
        contentTextView.textContainer.maximumNumberOfLines = 15
        contentTextView.delegate = self
        collectionView.addDashedBorder()
        

        charactorTextField.delegate = self
        titleTextField.delegate = self
        
        charactorTextField.addTarget(self, action: #selector(setChar), for: .touchDown)
        
        writeDataManager.getConcept(date: date) { data in
            self.concept = data
            self.pickerView.data = data
            self.pickerView.picker?.reloadAllComponents()
        }
        
        dataManager.getDiary(date: date) { result in
            self.data = result
            self.collectionView.reloadData()
        }
        
        if isEdit {
            dateButton.isHidden = true
            dateButton.isUserInteractionEnabled = false
            let texts = data.first!.createAt.components(separatedBy: "-")
            date = Date(year: Int(texts[0])!, month: Int(texts[1])!, day: Int(texts[2])!)
            titleTextField.text = data.first!.title
            contentTextView.text = data.first!.content
            contentTextView.textColor = .label
            if data.count > 0 {
                if let d = data.first {
                    if d.conceptId > 0 {
                        charactorTextField.text = DummyData.character[d.conceptId]
                    }
                }
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "컨셉 기록"
        self.navigationItem.rightBarButtonItem = rightButton
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
        if concept.last != nil {
            info.idx = concept.last!.conceptId
            charactorTextField.text = concept.last!.name
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        middleButton?.removeFromSuperview()
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func dateTouchDown(_ sender: Any) {
        pickerView.setConstraint(view: self.view)
        pickerView.selectButton?.addTarget(self, action: #selector(selectTouchDown), for: .touchDown)
    }
    
    func setUnderLine(of textField: UITextField) {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: textField.frame.size.height-1, width: textField.frame.width, height: 1)
        border.backgroundColor = UIColor.lightGray.cgColor
        textField.layer.addSublayer(border)
    }
    
    func setButtonText() {
        dateButton.setAttributedTitle(NSAttributedString(string: date.fullText+"  ", attributes: [
            .font : UIFont.Notos(.bold, size: 12),
            .foregroundColor : UIColor.mainBlue
        ]), for: .normal)
    }
    
    func checkButton() {
        if info.content.isExists && info.title.isExists {
            rightButton.isEnabled = true
        } else {
            rightButton.isEnabled = false
        }
    }
    
    @objc func setChar() {
        
    }
    
    @objc func writeTouchDown() {
        if !isEdit {
            writeDataManager.sendWrite(info: info, date: date) { code in
                if code == 1000 {
                    self.pickerView.setSendConstraint(view: self.view)
                    self.pickerView.end?.addTarget(self, action: #selector(self.end), for: .touchDown)
                    self.pickerView.sendButton?.addTarget(self, action: #selector(self.back), for: .touchDown)
                } else {
                    self.presentAlert(title: "다시 시도해주시기 바랍니다.")
                }
            }
        } else {
            writeDataManager.patchWrite(info: info, date: date) { code in
                if code == 1000 {
                    self.navigationController?.popViewController(animated: true)
                } else {
                    self.presentAlert(title: "다시 시도해주시기 바랍니다.")
                }
            }
        }
    }
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func selectTouchDown() {
        date = pickerView.pickerView!.date
        pickerView.mainView.removeFromSuperview()
        setButtonText()
        writeDataManager.getConcept(date: date) { data in
            print(data)
            self.concept = data
            self.pickerView.data = data
            self.pickerView.picker?.reloadAllComponents()
        }
        
        if concept.last != nil {
            info.idx = concept.last!.conceptId
            charactorTextField.text = concept.last!.name
        }
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0
    }
    
    @objc func singleTapGestureCaptured(gesture: UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    
    @objc func charactorTouchDown() {
        pickerView.setSubConstraint(view: self.view)
        pickerView.selectCharactorButton?.addTarget(self, action: #selector(setCharactor), for: .touchDown)
    }
    
    @objc func setCharactor() {
        info.idx = pickerView.charactorPicker!.selectedRow(inComponent: 0)
        charactorTextField.text = pickerView.charactorPicker?.charctor[info.idx]
        pickerView.subView.removeFromSuperview()
        checkButton()
    }
    
    @objc func selectDown() {
        if pickerView.data.count > 0 {
            info.idx = pickerView.data[pickerView.picker!.selectedRow(inComponent: 0)].conceptId
        }
        pickerView.selectView.removeFromSuperview()
    }
    
    @objc func end() {
        self.navigationController?.popViewController(animated: true)
        self.tabBarController?.selectedIndex = 3
    }
}

extension ArchiveWriteViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = Device.bottomInset + Device.tabBarHeight - 200
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "내용을 입력해주세요."
            textView.textColor = UIColor.lightGray
        }
        self.view.frame.origin.y = 0
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        info.content = textView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        checkButton()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        return numberOfChars < 280
        
    }
}
 
extension ArchiveWriteViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 1 {
            pickerView.setPicker(view: self.view)
            pickerView.select?.addTarget(self, action: #selector(selectDown), for: .touchDown)
            self.view.endEditing(true)
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.tag == 0 {
            if let text = textField.text {
                info.title = text.trimmingCharacters(in: .whitespacesAndNewlines)
                checkButton()
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 1 {
            return false
        } else {
            return true
        }
    }
}

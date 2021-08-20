import UIKit

class ArchiveWritePicker: NSObject {
    weak var charactorPicker: CharactorPickerView?
    weak var pickerView: UIDatePicker?
    weak var selectButton: UIButton?
    weak var selectCharactorButton: UIButton?
    weak var sendButton: UIButton?
    weak var picker: UIPickerView?
    weak var select: UIButton?
    weak var end: UIButton?
    
    var data: [WriteConcept] = []
    
    var charctor: [String] = [
        "모스",
        "제이비",
        "리아",
        "이노",
        "시애나",
        "헤더",
        "로하",
        "로키",
        "폴",
        "주주",
        "옐로우",
        "마크",
        "뮤즈",
        "빈",
        "하이",
        "피즈",
        "베어"
    ]
    
    lazy var selectView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.init(white: 0, alpha: 0.26)
        
        let view = UIView()
        view.backgroundColor = .white
        view.cornerRadius = 6
        backgroundView.addSubview(view)
        view.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(400)
            
        }
        
        let cancelButton = UIButton()
        cancelButton.setImage(UIImage(named: ImgName.imgName(of: .cancel)), for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelTouchDown(_:)), for: .touchDown)
        view.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { make in
            make.top.right.equalToSuperview().inset(27)
        }
        
        let pickerView = UIPickerView(frame: view.frame)
        pickerView.dataSource = self
        pickerView.delegate = self
        self.picker = pickerView
        view.addSubview(pickerView)
        pickerView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(150)
            make.top.equalToSuperview().inset(30)
            make.left.right.equalToSuperview().inset(40)
        }
        
        let selectButton = UIButton()
        self.select = selectButton
        selectButton.setAttributedTitle(NSAttributedString(string: "선택", attributes: [
            .font : UIFont.Notos(.bold, size: 16),
            .foregroundColor : UIColor.mainBlue
        ]), for: .normal)
        selectButton.cornerRadius = 6
        selectButton.borderWidth = 1
        selectButton.borderColor = #colorLiteral(red: 0.7094730735, green: 0.7629908919, blue: 0.9359324574, alpha: 1)
        
        view.addSubview(selectButton)
        selectButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(40)
            make.bottom.equalToSuperview().inset(140)
            make.height.equalTo(50)
        }
        
        return backgroundView
    }()
    
    lazy var sendView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.init(white: 0, alpha: 0.26)
        
        let view = UIView()
        view.backgroundColor = .white
        view.cornerRadius = 6
        backgroundView.addSubview(view)
        view.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(25)
            make.centerY.equalToSuperview()
            make.height.equalTo(350)
            
        }
        
        let backgroundImage = UIImageView(image: UIImage(named: ImgName.imgName(of: .sendBackground)))
        view.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.bottom.left.top.right.equalToSuperview()
        }
        
        let cancelButton = UIButton()
        cancelButton.setImage(UIImage(named: ImgName.imgName(of: .cancel)), for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelTouchDown(_:)), for: .touchDown)
        view.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { make in
            make.top.right.equalToSuperview().inset(27)
        }
        sendButton = cancelButton
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "coin")
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(50)
            make.height.equalTo(115)
            make.width.equalTo(149)
        }
        
        let label = UILabel(frame: view.frame)
        label.makeHightledText(all: "리워드 5P 획득", for: "5P", font: .Notos(.bold, size: 20))
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(125)
        }
        
        let subLabel = UILabel(frame: view.frame)
        subLabel.text = "획득한 리워드는 마이페이지에서 확인하세요"
        subLabel.font = .Notos(.regular, size:11)
        subLabel.textColor = .gray3
        view.addSubview(subLabel)
        subLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(90)
        }
        
        let borderView = UIView(frame: view.frame)
        borderView.backgroundColor = .gray3
        view.addSubview(borderView)
        borderView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(10)
            make.bottom.equalTo(61)
            make.height.equalTo(1)
        }
        
        let endButton = UIButton(frame: view.frame)
        endButton.setAttributedTitle(NSAttributedString(string: "리워드 확인하기", attributes: [
            .font : UIFont.Notos(.regular, size: 14),
            .foregroundColor : UIColor.label
        ]), for: .normal)
        self.end = endButton
        view.addSubview(endButton)
        endButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(60)
        }
        
        return backgroundView
    }()
    
    lazy var subView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.init(white: 0, alpha: 0.26)
        
        let view = UIView()
        view.backgroundColor = .white
        view.cornerRadius = 35
        backgroundView.addSubview(view)
        view.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(350)
        }
        
        let cancelButton = UIButton()
        cancelButton.setImage(UIImage(named: ImgName.imgName(of: .cancel)), for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelTouchDown(_:)), for: .touchDown)
        view.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { make in
            make.top.right.equalToSuperview().inset(27)
        }
        
        let pickerView = CharactorPickerView()
        self.charactorPicker = pickerView
        view.addSubview(pickerView)
        pickerView.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(30)
            make.top.equalToSuperview().inset(40)
            make.bottom.equalToSuperview().inset(150)
        }
        
        let selectButton = UIButton()
        self.selectCharactorButton = selectButton
        selectButton.setAttributedTitle(NSAttributedString(string: "선택", attributes: [
            .font : UIFont.Notos(.bold, size: 16),
            .foregroundColor : UIColor.mainBlue
        ]), for: .normal)
        selectButton.cornerRadius = 6
        selectButton.borderWidth = 1
        selectButton.borderColor = #colorLiteral(red: 0.7094730735, green: 0.7629908919, blue: 0.9359324574, alpha: 1)
        
        view.addSubview(selectButton)
        selectButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(40)
            make.bottom.equalToSuperview().inset(90)
            make.height.equalTo(50)
        }
        
        return backgroundView
    }()

    
    lazy var mainView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.init(white: 0, alpha: 0.26)
        
        let view = UIView()
        view.backgroundColor = .white
        view.cornerRadius = 35
        backgroundView.addSubview(view)
        view.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(350)
        }
        
        let cancelButton = UIButton()
        cancelButton.setImage(UIImage(named: ImgName.imgName(of: .cancel)), for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelTouchDown(_:)), for: .touchDown)
        view.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { make in
            make.top.right.equalToSuperview().inset(27)
        }
        
        let pickerView = UIDatePicker()
        pickerView.locale = Locale(identifier: "ko_KR")
        pickerView.datePickerMode = .date
        pickerView.preferredDatePickerStyle = .wheels
        pickerView.setDate(Date(), animated: true)
        pickerView.minimumDate = Date(year: 2000, month: 1, day: 1)
        pickerView.maximumDate = Date(year: 2030, month: 12, day: 31)
        self.pickerView = pickerView
        self.pickerView?.tintColor = .mainBlue
        view.addSubview(pickerView)
        pickerView.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(30)
            make.top.equalToSuperview().inset(40)
            make.bottom.equalToSuperview().inset(150)
        }
        
        let selectButton = UIButton()
        self.selectButton = selectButton
        selectButton.setAttributedTitle(NSAttributedString(string: "선택", attributes: [
            .font : UIFont.Notos(.bold, size: 16),
            .foregroundColor : UIColor.mainBlue
        ]), for: .normal)
        selectButton.cornerRadius = 6
        selectButton.borderWidth = 1
        selectButton.borderColor = #colorLiteral(red: 0.7094730735, green: 0.7629908919, blue: 0.9359324574, alpha: 1)
        
        view.addSubview(selectButton)
        selectButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(40)
            make.bottom.equalToSuperview().inset(90)
            make.height.equalTo(50)
        }
        
        return backgroundView
    }()
    
    func setPicker(view :UIView) {
        view.addSubview(selectView)
        selectView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    func setConstraint(view: UIView) {
        view.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    func setSubConstraint(view: UIView) {
        view.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    func setSendConstraint(view: UIView) {
        view.addSubview(sendView)
        sendView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    @objc func cancelTouchDown(_ sender: UIButton) {
        selectView.removeFromSuperview()
        sendView.removeFromSuperview()
        subView.removeFromSuperview()
        mainView.removeFromSuperview()
    }
}

extension ArchiveWritePicker: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        print(data)
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row].name
    }
    
}

extension ArchiveWritePicker: UIPickerViewDelegate {
    
}

import UIKit

class PreviewAdapter: NSObject {
    private var selected: ((_ of: UIButton ) -> Void)?
    private let chevronRight = "chevron.right"
    
    init(selected: @escaping (_ of: UIButton ) -> Void) {
        super.init()
        self.selected = selected
    }
    
    lazy var backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.frame = UIScreen.main.bounds
        backgroundView.backgroundColor = UIColor(white: 0, alpha: 0.42)
        return backgroundView
    }()
    
    lazy var view: UIView = {
        
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.frame = CGRect(x: 0, y: UIScreen.main.bounds.height-490, width: UIScreen.main.bounds.width, height: 490)
        view.cornerRadius = 35
        let cancelButton = UIButton()
        cancelButton.tag = 0
        cancelButton.setImage(UIImage(named: ImgName.imgName(of: .cancel)), for: .normal)
        view.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { make in
            make.top.right.equalToSuperview().inset(27)
        }
        cancelButton.addTarget(self, action: #selector(touchDown(_:)), for: .touchDown)
        
        let titleLabel = UILabel()
        titleLabel.font = .Notos(.bold, size: 20)
        titleLabel.textColor = .mainBlue
        titleLabel.text = "오늘의 친구를 만나보세요!"
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(70)
        }
        
        let titleDescriptionLabel = UILabel()
        titleDescriptionLabel.font = .Notos(.regular, size: 12)
        titleDescriptionLabel.textColor = .gray2
        titleDescriptionLabel.numberOfLines = 0
        titleDescriptionLabel.textAlignment = .center
        titleDescriptionLabel.text = "아래 테스트를 통해 추천받은 오늘의 친구를 만나면\n나를 조금 더 쉽고 재미있게 알아갈 수 있어요"
        view.addSubview(titleDescriptionLabel)
        titleDescriptionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(115)
            make.left.right.equalToSuperview().inset(50)
        }
        
        let borderView = UIView()
        borderView.frame = CGRect(x: 0, y: 0, width: 0, height: 1)
        borderView.backgroundColor = .lightGray
        view.addSubview(borderView)
        borderView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalToSuperview().inset(172)
            make.left.right.equalToSuperview().inset(49)
        }
        
        let stepLabel1 = UILabel()
        stepLabel1.attributedText = makeAttributedText(text: "나는 어떤 성향인지 궁금하다면?")
        view.addSubview(stepLabel1)
        stepLabel1.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(190)
            make.centerX.equalToSuperview()
        }
        
        let stepLabel2 = UILabel()
        stepLabel2.attributedText = makeAttributedText(text: "나와 함께할 친구가 궁금하다면?")
        view.addSubview(stepLabel2)
        stepLabel2.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(293)
            make.centerX.equalToSuperview()
        }
        
        let testButton = makeButton(text: "나의 성향 알기", tag: 1)
        view.addSubview(testButton)
        testButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(218)
            make.left.right.equalToSuperview().inset(49)
            make.height.equalTo(55)
        }
        testButton.backgroundColor = .gradientLeft
        
        let recommendButton = makeButton(text: "컨셉 추천받기", tag: 2)
        view.addSubview(recommendButton)
        recommendButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(320)
            make.left.right.equalToSuperview().inset(49)
            make.height.equalTo(55)
        }
        recommendButton.backgroundColor = .gradientLeft
        
        
        return view
    }()
    
    func makeAttributedText(text: String) -> NSMutableAttributedString {
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttributes([
            .font : UIFont.Notos(.regular, size: 11),
            .foregroundColor : UIColor.gray3
        ], range: (text as NSString).range(of: text))
        attributedText.addAttribute(.underlineStyle, value: NSUnderlineStyle.thick.rawValue,
                                    range: (text as NSString).range(of: text))
        attributedText.addAttribute(.underlineColor, value: UIColor.borderColor,
                                    range: (text as NSString).range(of: text))
        return attributedText
    }
    
    func makeButton(text: String, tag: Int) -> UIButton {
        let testButton = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 1))
        testButton.tag = tag
        testButton.tintColor = .white
        testButton.setAttributedTitle(
            NSAttributedString(string: text,
                               attributes: [
                                .font : UIFont.Notos(.bold, size: 17),
                                .foregroundColor : UIColor.white
                               ]), for: .normal)
        testButton.cornerRadius = 6
        testButton.addTarget(self, action: #selector(touchDown(_:)), for: .touchDown)
        return testButton
    }
    
    @objc func touchDown(_ sender: UIButton) {
        guard let selected = selected else { return }
        backgroundView.removeFromSuperview()
        view.removeFromSuperview()
        selected(sender)
    }
}

import UIKit

class HomeCustom: NSObject {
    private let buttonImg: [String] = [ImgName.imgName(of: .play), ImgName.imgName(of: .pause)]
    private let buttonTitle: [String] = ["다시시작 ", "쉬어가기 "]
    weak var timeLabel: UILabel?
    weak var timeButton: UIButton?
    weak var titleLabel: UILabel?
    
    lazy var charactorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImgName.imgName(of: .defaultImg))
        return imageView
    }()
    
    lazy var changeButton: UIButton = {
        let button = UIButton()
        button.contentMode = .scaleAspectFit
        button.setImage(UIImage(named: ImgName.imgName(of: .moon)), for: .normal)
        return button
    }()
    
    lazy var menu: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
        view.backgroundColor = .systemBackground
        view.cornerRadius = 10
        let titleLabel = UILabel()
        titleLabel.font = .Notos(.regular, size: 12)
        titleLabel.textColor = .label
        self.titleLabel = titleLabel
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.left.equalToSuperview().inset(25)
        }
        
        let timeLabel = UILabel()
        self.timeLabel = timeLabel
        timeLabel.textColor = .mainBlue
        timeLabel.font = .Notos(.black, size: 22)
        timeLabel.text = ""
        view.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(40)
            make.left.equalToSuperview().inset(25)
        }
        
        let timeButton = UIButton()
        self.timeButton = timeButton
        timeButton.cornerRadius = 5
        timeButton.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        timeButton.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        timeButton.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        timeButton.backgroundColor = .mainBlue
        setButton(timeButton, isPlay: true)
        view.addSubview(timeButton)
        timeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(40)
            make.right.equalToSuperview().inset(20)
            make.height.equalTo(27)
            make.width.equalTo(70)
        }
        
        return view
    }()
    
    lazy var infoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImgName.imgName(of: .info)), for: .normal)
        return button
    }()
    
    func setConstraint(view: UIView) {
        view.addSubview(changeButton)
        changeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.left.equalToSuperview().inset(30)
        }
        
        view.addSubview(infoButton)
        infoButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(60)
            make.right.equalToSuperview().inset(30)
        }
        
        view.addSubview(menu)
        menu.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(115)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(90)
        }
        
        view.addSubview(charactorImageView)
        charactorImageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(80)
            make.centerX.equalToSuperview()
        }
        
        setButton(timeButton!, isPlay: true)
        
    }
    
    func setButton(_ button: UIButton , isPlay: Bool) {
        var btnTitle = ""
        var btnImg = ""
        switch isPlay{
        case true:
            btnTitle = buttonTitle[1]
            btnImg = buttonImg[1]
        case false:
            btnTitle = buttonTitle[0]
            btnImg = buttonImg[0]
        }
        button.setAttributedTitle(NSAttributedString(string: btnTitle,
                                                     attributes: [
                                                        .font : UIFont.Notos(.regular, size: 12),
                                                        .foregroundColor : UIColor.white
                                                     ]), for: .normal)
        button.setImage(UIImage(named: btnImg), for: .normal)
    }
}

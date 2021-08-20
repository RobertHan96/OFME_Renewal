import UIKit

class QuestionAllSubView {
    
    weak var button: UIButton?
    weak var end: UIButton?
    
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
        button = cancelButton
        
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
        label.makeHightledText(all: "리워드 2P 획득", for: "2P", font: .Notos(.bold, size: 20))
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
    
    func setSendConstraint(view: UIView) {
        view.addSubview(sendView)
        sendView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    @objc func cancelTouchDown(_ sender: UIButton) {
        sendView.removeFromSuperview()
    }
}

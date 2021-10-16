import UIKit

class FinishSubView: NSObject {
    weak var confirmButton: UIButton?
    
    lazy var mainView: UIView = {
        let device = UIScreen.main.bounds
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: device.width, height: device.height))
        let view = UIView(frame: CGRect(x: 0, y: 0, width: device.width, height: 600))
        view.backgroundColor = .systemBackground
        view.cornerRadius = 6
        backgroundView.backgroundColor = .init(white: 0, alpha: 0.42)
        backgroundView.addSubview(view)
        
        view.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(215)
        }
        
        let titleLabel = UILabel()
        titleLabel.font = .Notos(.bold, size: 16)
        titleLabel.textColor = .mainBlue
        titleLabel.text = "컨셉 종료하기"
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.centerX.equalToSuperview()
        }
        
        let subLabel = UILabel()
        subLabel.font = .Notos(.regular, size: 14)
        subLabel.numberOfLines = 0
        subLabel.textAlignment = .center
        subLabel.text = "컨셉을 종료하면 경과시간과 적용한\n액션이 리셋됩니다. 종료하시겠습니까?"
        
        view.addSubview(subLabel)
        subLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(70)
            make.left.right.equalToSuperview().inset(60)
        }
        
        let borderView = UIView()
        borderView.backgroundColor = .lightGray
        view.addSubview(borderView)
        borderView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(65)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(1)
        }
        
        let verticalView = UIView()
        verticalView.backgroundColor = .lightGray
        view.addSubview(verticalView)
        verticalView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(1)
            make.bottom.equalToSuperview().inset(19)
            make.height.equalTo(22)
        }
        
        let cancelButton = UIButton()
        cancelButton.setAttributedTitle(NSAttributedString(string: "아니요",
                                                           attributes: [
                                                            .font : UIFont.Notos(.regular, size: 14),
                                                            .foregroundColor : UIColor.gray4
                                                           ]), for: .normal)
        cancelButton.addTarget(self, action: #selector(removeView), for: .touchDown)
        
        view.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalTo(verticalView)
            make.top.equalTo(borderView)
            make.bottom.equalToSuperview()
        }
        
        let confirmButton = UIButton()
        confirmButton.setAttributedTitle(NSAttributedString(string: "네 종료할게요",
                                                           attributes: [
                                                            .font : UIFont.Notos(.regular, size: 14),
                                                            .foregroundColor : UIColor.label
                                                           ]), for: .normal)
        self.confirmButton = confirmButton
        view.addSubview(confirmButton)
        confirmButton.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.left.equalTo(verticalView)
            make.top.equalTo(borderView)
            make.bottom.equalToSuperview()
        }
        
        return backgroundView
    }()
    
    func setConstraint(view: UIView) {
        view.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.top.bottom.right.left.equalToSuperview()
        }
    }
    
    @objc func removeView() {
        mainView.removeFromSuperview()
    }
}

import UIKit


class ConceptFirstMenu: NSObject {
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle(
            NSAttributedString(string: "다음",
                               attributes: [
                                .font : UIFont.Notos(.bold, size: 16),
                                .foregroundColor : UIColor.mainBlue
                               ]), for: .normal)
        button.backgroundColor = .purple
        button.cornerRadius = 6
        
        return button
    }()
    
    func setButton(view: UIView) {
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(85)
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(55)
        }
    }
}

import UIKit

class QuestionSubView {
    weak var useButton: UIButton?
    
    
    lazy var confrimView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.init(white: 0, alpha: 0.26)
        
        let view = UIView()
        view.backgroundColor = .white
        view.cornerRadius = 6
        backgroundView.addSubview(view)
        view.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
            make.height.equalTo(215)
        }
        
        let titleLabel = UILabel(frame: view.frame)
        titleLabel.text = "Q&A 둘러보기"
        titleLabel.font = .Notos(.bold, size: 16)
        titleLabel.textColor = .mainBlue
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.left.right.equalToSuperview()
        }
        
        let descriptLabel = UILabel(frame: view.frame)
        descriptLabel.text = "Q&A를 둘러보기 위해 3p가 사용됩니다.\n선택한 Q&A를 둘러보시겠습니까?"
        descriptLabel.textAlignment = .center
        descriptLabel.font = .Notos(.regular, size: 14)
        descriptLabel.numberOfLines = 0
        
        view.addSubview(descriptLabel)
        descriptLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(70)
            make.left.right.equalToSuperview().inset(50)
        }
        
        let borderView = UIView(frame: view.frame)
        borderView.backgroundColor = .gray4
        view.addSubview(borderView)
        borderView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(65)
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(1)
        }
        
        let middleBorderView = UIView(frame: view.frame)
        middleBorderView.backgroundColor = .gray4
        view.addSubview(middleBorderView)
        middleBorderView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(164)
            make.height.equalTo(22)
            make.centerX.equalToSuperview()
            make.width.equalTo(1)
        }
        
        let nextButton = UIButton(frame: view.frame)
        nextButton.setAttributedTitle(NSAttributedString(string: "다음에 둘러볼게요"
                                                         , attributes: [
                                                            .font : UIFont.Notos(.regular, size: 14),
                                                            .foregroundColor : UIColor.gray4
                                                         ]), for: .normal)
        nextButton.addTarget(self, action: #selector(cancel), for: .touchDown)
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalTo(middleBorderView)
            make.top.equalTo(borderView)
            make.bottom.equalToSuperview()
        }
        
        let useButton = UIButton(frame: view.frame)
        useButton.setAttributedTitle(NSAttributedString(string: "네 사용할게요"
                                                         , attributes: [
                                                            .font : UIFont.Notos(.regular, size: 14),
                                                            .foregroundColor : UIColor.label
                                                         ]), for: .normal)
        self.useButton = useButton
        view.addSubview(useButton)
        useButton.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.left.equalTo(middleBorderView)
            make.top.equalTo(borderView)
            make.bottom.equalToSuperview()
        }
        
        
        
        return backgroundView
    }()
    
    lazy var quitView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.init(white: 0, alpha: 0.26)
        
        let view = UIView()
        view.backgroundColor = .white
        view.cornerRadius = 6
        backgroundView.addSubview(view)
        view.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
            make.height.equalTo(215)
        }
        
        let titleLabel = UILabel(frame: view.frame)
        titleLabel.text = "리워드 부족"
        titleLabel.font = .Notos(.bold, size: 16)
        titleLabel.textColor = #colorLiteral(red: 1, green: 0.2487661541, blue: 0.04770631343, alpha: 1)
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.left.right.equalToSuperview()
        }
        
        let descriptLabel = UILabel(frame: view.frame)
        descriptLabel.text = "Q&A를 둘러보기 위한 리워드가 부족합니다.\n리워드 획득 후 다시 시도해 주세요."
        descriptLabel.textAlignment = .center
        descriptLabel.font = .Notos(.regular, size: 14)
        descriptLabel.numberOfLines = 0
        
        view.addSubview(descriptLabel)
        descriptLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(70)
            make.left.right.equalToSuperview().inset(50)
        }
        
        let borderView = UIView(frame: view.frame)
        borderView.backgroundColor = .gray4
        view.addSubview(borderView)
        borderView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(65)
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(1)
        }
    
        let nextButton = UIButton(frame: view.frame)
        nextButton.setAttributedTitle(NSAttributedString(string: "확인"
                                                         , attributes: [
                                                            .font : UIFont.Notos(.regular, size: 14),
                                                            .foregroundColor : UIColor.label
                                                         ]), for: .normal)
        nextButton.addTarget(self, action: #selector(cancel), for: .touchDown)
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.right.left.equalToSuperview()
            make.top.equalTo(borderView)
            make.bottom.equalToSuperview()
        }
        
        
        return backgroundView
    }()
    
    lazy var noView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.init(white: 0, alpha: 0.26)
        
        let view = UIView()
        view.backgroundColor = .white
        view.cornerRadius = 6
        backgroundView.addSubview(view)
        view.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
            make.height.equalTo(215)
        }
        
        let titleLabel = UILabel(frame: view.frame)
        titleLabel.text = "답변 없음"
        titleLabel.font = .Notos(.bold, size: 16)
        titleLabel.textColor = #colorLiteral(red: 1, green: 0.2487661541, blue: 0.04770631343, alpha: 1)
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.left.right.equalToSuperview()
        }
        
        let descriptLabel = UILabel(frame: view.frame)
        descriptLabel.text = "해당 질문에 대한 답변이 없습니다.\n답변 등록 이후 확인 하실 수 있습니다."
        descriptLabel.textAlignment = .center
        descriptLabel.font = .Notos(.regular, size: 14)
        descriptLabel.numberOfLines = 0
        
        view.addSubview(descriptLabel)
        descriptLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(70)
            make.left.right.equalToSuperview().inset(50)
        }
        
        let borderView = UIView(frame: view.frame)
        borderView.backgroundColor = .gray4
        view.addSubview(borderView)
        borderView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(65)
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(1)
        }
    
        let nextButton = UIButton(frame: view.frame)
        nextButton.setAttributedTitle(NSAttributedString(string: "확인"
                                                         , attributes: [
                                                            .font : UIFont.Notos(.regular, size: 14),
                                                            .foregroundColor : UIColor.label
                                                         ]), for: .normal)
        nextButton.addTarget(self, action: #selector(cancel), for: .touchDown)
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.right.left.equalToSuperview()
            make.top.equalTo(borderView)
            make.bottom.equalToSuperview()
        }
        
        
        return backgroundView
    }()
    
    @objc func cancel() {
        self.quitView.removeFromSuperview()
        self.confrimView.removeFromSuperview()
        self.noView.removeFromSuperview()
    }
    
    func addConfrimView(_ view:UIView) {
        view.addSubview(confrimView)
        confrimView.snp.makeConstraints { make in
            make.top.right.bottom.left.equalToSuperview()
        }
    }
    
    func addNoView(_ view:UIView) {
        view.addSubview(noView)
        noView.snp.makeConstraints { make in
            make.top.right.bottom.left.equalToSuperview()
        }
    }
    
    func addQuitView(_ view:UIView) {
        view.addSubview(quitView)
        quitView.snp.makeConstraints { make in
            make.top.right.bottom.left.equalToSuperview()
        }
    }
}

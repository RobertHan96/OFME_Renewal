import UIKit

class TestConceptHeader: UICollectionReusableView {
    
    static let identifer = "TestConceptHeader"
    
    let titleLabel: UILabel = UILabel()
    let descriptLabel: UILabel = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        makeConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        titleLabel.font = .Notos(.regular, size: 11)
        titleLabel.textColor = .gray2
        titleLabel.cornerRadius = 6
        titleLabel.backgroundColor = .purple
        
        descriptLabel.font = .Notos(.regular, size: 14)
        descriptLabel.textColor = .gray3
    }
    
    func makeConstraint() {
        self.addSubview(titleLabel)
        self.addSubview(descriptLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(40)
        }
        
        descriptLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(65)
        }
    }
    
    
}

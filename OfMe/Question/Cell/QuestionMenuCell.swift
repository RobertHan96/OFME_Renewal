import UIKit

class QuestionMenuCell: UICollectionViewCell {
    
    static let identifier = "QuestionMenuCell"

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = .Notos(.regular, size: 12)
    }
    
    func updateUI(row: Int, idx: Int, title: String) {
        if row == idx {
            self.backgroundColor = .mainBlue
            self.borderColor = .mainBlue
            titleLabel.font = .Notos(.bold, size: 12)
            titleLabel.textColor = .white
        } else {
            self.backgroundColor = .systemBackground
            self.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            titleLabel.font = .Notos(.regular, size: 12)
            titleLabel.textColor = .gray2
        }
        titleLabel.text = title
    }

}

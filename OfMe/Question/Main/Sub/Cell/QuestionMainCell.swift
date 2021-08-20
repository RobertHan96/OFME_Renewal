import UIKit

class QuestionMainCell: UICollectionViewCell {
    
    static let identfier = "QuestionMainCell"

    @IBOutlet weak var dotView: UIView!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var changeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dotView.backgroundColor = .mainBlue
        conditionLabel.font = .Notos(.regular, size: 10)
        titleLabel.font = .Notos(.regular, size: 14)
        conditionLabel.textColor = .gray3
    }
    
    func updateUI(data: SubAllQuestion) {
        if let share = data.share {
            if share == "Y" {
                dotView.backgroundColor = .mainBlue
                conditionLabel.text = "공유완료"
            } else {
                dotView.backgroundColor = #colorLiteral(red: 0.9761716723, green: 0.7869933248, blue: 0.1295944154, alpha: 1)
                conditionLabel.text = ""
            }
            changeButton.isHidden = false
            changeButton.isUserInteractionEnabled = true
        } else {
            dotView.backgroundColor = .gray4
            conditionLabel.text = ""
            changeButton.isHidden = true
            changeButton.isUserInteractionEnabled = false
        }
        
        titleLabel.text = data.question
        
    }

}

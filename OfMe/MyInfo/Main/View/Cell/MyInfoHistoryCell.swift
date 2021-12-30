import UIKit

class MyInfoHistoryCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    static let identifier = "MyInfoHistoryCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.font = .Notos(.regular, size:12)
        titleLabel.textColor = .mainBlue
        titleLabel.adjustsFontSizeToFitWidth = true
        
        timeLabel.font = .Notos(.regular, size:10)
        timeLabel.textColor = .gray3
    }
    
    func updateUI(data: MyHistory) {
        titleLabel.text = data.highlight
        timeLabel.text = data.createAt
    }

}

import UIKit

class QuestionSubCell: UICollectionViewCell {
    
    static let identifier = "QuestionSubCell"

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var newLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        newLabel.isHidden = true
        
        pointLabel.font = .Notos(.regular, size: 12)
        pointLabel.textColor = .mainBlue
        
        titleLabel.font = .Notos(.regular, size: 14)
    }
    
    func updateUI(data: QuestionView) {
        if let _ = data.aroundId {
            imageView.image = UIImage(named: ImgName.imgName(of: .unlock))
            pointLabel.isHidden = true
        } else {
            imageView.image = UIImage(named: ImgName.imgName(of: .lock))
            pointLabel.isHidden = false
        }
        titleLabel.text = data.question
    }
}

import UIKit

class CommentCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var contentLabel: UILabel!
    
    static let identifier = "CommentCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentLabel.font = .Notos(.regular, size: 12)
        nameLabel.font = .Notos(.regular, size: 12)
        dateLabel.font = .Notos(.regular, size: 10)
        
        actionButton.setAttributedTitle(NSAttributedString(string: "신고", attributes: [
            .font : UIFont.Notos(.regular, size: 12),
            .foregroundColor : UIColor.label
        ]), for: .normal)
        
    }
    
    func updateUI(data: QuestionDetail) {
        if let url = data.imgUrl {
            imageView.kf.setImage(with: URL(string: url))
        }
        actionButton.tag = data.answerId
        nameLabel.text = data.nickname
        dateLabel.text = data.createAt
        contentLabel.text = data.answer
        
        if let userId = UserDefaults.standard.object(forKey: "userID") as? Int {
            if userId == data.userId {
                actionButton.setTitle("", for: .normal)
                actionButton.isHidden = true
                actionButton.isUserInteractionEnabled = false
            } else {
                actionButton.setTitle("신고", for: .normal)
                actionButton.isHidden = false
                actionButton.isUserInteractionEnabled = true
            }
        }
    }
}

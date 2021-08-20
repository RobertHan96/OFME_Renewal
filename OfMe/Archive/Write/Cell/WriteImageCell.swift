import UIKit

class WriteImageCell: UICollectionViewCell {
    static let identifier = "WriteImageCell"

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateUI(image: UIImage) {
        imageView.image = image
    }

}

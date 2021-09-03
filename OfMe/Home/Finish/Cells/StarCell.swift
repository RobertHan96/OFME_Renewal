import UIKit

class StarCell: UICollectionViewCell {
    static let identifier = "StarCell"
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func updateUI(row: Int, idx: Int) {
        if row <= idx {
            imageView.image = UIImage(named: ImgName.imgName(of: .starFill))
        } else {
            imageView.image = UIImage(named: ImgName.imgName(of: .starNonFill))
        }
    }

    private func setupUI() {
        self.backgroundColor = .endCharacterBtnBackground
    }
}

import UIKit

class MyInfoCharCell: UICollectionViewCell {
    
    static let identifier = "MyInfoCharCell"
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        label.font = .Notos(.regular, size: 12)
    }
    
    func updateUI(data: MyFriend) {
        label.text = data.name
        imageView.kf.setImage(with: URL(string: data.url))
        if data.conceptPoint == 0 {
            [star1,star2,star3,star4,star5].forEach {
                $0.image = UIImage(named: ImgName.imgName(of: .starSmall))
            }
        } else if data.conceptPoint == 1 {
            [star2,star3,star4,star5].forEach {
                $0.image = UIImage(named: ImgName.imgName(of: .starSmall))
            }
            [star1].forEach {
                $0.image = UIImage(named: ImgName.imgName(of: .starFillSmall))
            }
        } else if data.conceptPoint == 2 {
            [star3,star4,star5].forEach {
                $0.image = UIImage(named: ImgName.imgName(of: .starSmall))
            }
            [star1,star2].forEach {
                $0.image = UIImage(named: ImgName.imgName(of: .starFillSmall))
            }
        } else if data.conceptPoint == 3 {
            [star4,star5].forEach {
                $0.image = UIImage(named: ImgName.imgName(of: .starSmall))
            }
            [star1,star2,star3].forEach {
                $0.image = UIImage(named: ImgName.imgName(of: .starFillSmall))
            }
        } else if data.conceptPoint == 4 {
            [star5].forEach {
                $0.image = UIImage(named: ImgName.imgName(of: .starSmall))
            }
            [star1,star2,star3,star4].forEach {
                $0.image = UIImage(named: ImgName.imgName(of: .starFillSmall))
            }
        } else {
            [star1,star2,star3,star4,star5].forEach {
                $0.image = UIImage(named: ImgName.imgName(of: .starFillSmall))
            }
        }
    }
}

import UIKit

class TestConceptDescriptCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TestConceptDescriptCollectionViewCell"

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateUI(text: String, word: String) {
        titleLabel.makeConceptTestHeaderCellHightledText(all: text, for: word, font: .Notos(.regular, size: 18))
    }
    
    func updateUI() {
        
    }
}

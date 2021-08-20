import UIKit

class ConceptResultTextCell: UICollectionViewCell {
    static let identifier = "ConceptResultTextCell"
    private let data: ConceptDummy = ConceptDummy()

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        descriptLabel.font = .Notos(.regular, size: 12)
        descriptLabel.textColor = .gray2
    }
    
    func updateUI(idx: Int) {
        titleLabel.makeHightledText(all: data.titles[idx],
                                    for: data.titleHightLightText[idx],
                                    font: .Notos(.regular, size: 18))
        descriptLabel.text = data.contentText[idx]
    }
    
    func update(idx: Int, result: ConceptResult) {
        titleLabel.makeHightledText(all: "\(result.name)\(data.titles[idx])",
                                    for: data.titleHightLightText[idx],
                                    font: .Notos(.regular, size: 18))
        switch idx {
        case 0:
            descriptLabel.text = result.advantage
        case 1:
            descriptLabel.text = result.habit
        case 2:
            descriptLabel.text = result.behavior
        default:
            descriptLabel.text = result.value
        }
    }

}

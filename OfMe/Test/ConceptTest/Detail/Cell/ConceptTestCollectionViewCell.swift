import UIKit

class ConceptTestCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ConceptTestCollectionViewCell"

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.font = .Notos(.regular, size: 14)
    }
    
    func updateUI(idx: Int, row: Int, title: String) {
        titleLabel.text = title
        
        if idx == row {
            self.backgroundColor = #colorLiteral(red: 0.2289258242, green: 0.3856725693, blue: 0.8486357331, alpha: 1)
            titleLabel.font = .Notos(.bold, size: 14)
            titleLabel.textColor = .white
        } else {
            self.backgroundColor = .systemBackground
            titleLabel.font = .Notos(.regular, size: 14)
            titleLabel.textColor = .label
        }
    }
    
    func updateUI(idx: Int, row: Int, data: TestConceptSecond) {
        if row == 1 {
            titleLabel.text = data.answer1
        } else if row == 2 {
            titleLabel.text = data.answer2
        } else if row == 3 {
            titleLabel.text = data.answer3
        } else {
            titleLabel.text = data.answer4
        }
        
        if idx == row {
            self.backgroundColor = #colorLiteral(red: 0.2289258242, green: 0.3856725693, blue: 0.8486357331, alpha: 1)
            titleLabel.font = .Notos(.bold, size: 14)
            titleLabel.textColor = .white
        } else {
            self.backgroundColor = .systemBackground
            titleLabel.font = .Notos(.regular, size: 14)
            titleLabel.textColor = .label
        }
    }
    
    func updateUI(idx: Int, row: Int, data: TestDummy) {
        if row == 1 {
            titleLabel.text = data.answer1
        } else if row == 2 {
            titleLabel.text = data.answer2
        } else if row == 3 {
            titleLabel.text = data.answer3
        } else {
            titleLabel.text = data.answer4
        }
        
        if idx == row {
            self.backgroundColor = #colorLiteral(red: 0.2289258242, green: 0.3856725693, blue: 0.8486357331, alpha: 1)
            titleLabel.font = .Notos(.bold, size: 14)
            titleLabel.textColor = .white
        } else {
            self.backgroundColor = .systemBackground
            titleLabel.font = .Notos(.regular, size: 14)
            titleLabel.textColor = .label
        }
    }

}

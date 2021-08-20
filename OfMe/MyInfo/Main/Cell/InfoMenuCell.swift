//
//  InfoMenuCell.swift
//  OfMe
//
//  Created by 김태훈 on 2021/07/23.
//

import UIKit

class InfoMenuCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    static let identifier = "InfoMenuCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = .Notos(.bold, size: 14)
    }

    func updateUI(text: String) {
        titleLabel.text = text
    }
}

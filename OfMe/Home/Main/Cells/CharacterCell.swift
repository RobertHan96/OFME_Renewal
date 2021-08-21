//
//  CharacterCell.swift
//  OfMe
//
//  Created by HanaHan on 2021/08/22.
//

import UIKit

class CharacterCell: UITableViewCell {
    @IBOutlet weak var charaterImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupUI() {
        charaterImage.layer.cornerRadius = 10
        charaterImage.clipsToBounds = true
    }
    
}

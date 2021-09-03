//
//  FinishButtonCell.swift
//  OfMe
//
//  Created by HanaHan on 2021/09/03.
//

import UIKit


class FinishButtonCell: UITableViewCell {
    @IBOutlet weak var ratingLaterButton: UIButton!
    @IBOutlet weak var endConceptButton: UIButton!
    @IBOutlet weak var infromTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupUI() {
        endConceptButton.backgroundColor = .ofMeColor
    }
    
    @IBAction func endConceptButtonDidClicked(_ sender: UIButton) {
        
    }
    @IBAction func ratingLaterButtonDidClicked(_ sender: UIButton) {
        
    }
}

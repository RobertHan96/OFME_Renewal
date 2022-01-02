//
//  NewEmptyConceptHistoryTableViewCell.swift
//  OfMe
//
//  Created by HanaHan on 2022/01/03.
//

import UIKit

class TableViewHeaderCell: UITableViewCell {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var totalConceptCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(totalConceptCount: Int) {
        totalConceptCountLabel.text = "\(totalConceptCount)"
    }
    
    private func setupUI() {
        questionLabel.textColor = .typoBlack
        headerTitleLabel.textColor = .typoBlue
        totalConceptCountLabel.textColor = .totalConceptHistoryLabelColor
    }
}


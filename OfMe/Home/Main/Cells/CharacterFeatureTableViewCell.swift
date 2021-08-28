//
//  CharacterFeatureTableViewCell.swift
//  OfMe
//
//  Created by HanaHan on 2021/08/22.
//

import UIKit

class CharacterFeatureTableViewCell: UITableViewCell {
    @IBOutlet weak var featureNameLabel: UILabel!
    @IBOutlet weak var featureDescriptionLabel: PaddingLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // TableView로부터 전달 받은 데이터를 cell에 적용
    func setTableViewCellDataSource() {
        
    }
    
    private func setupUI() {
        self.backgroundColor = .clear
    }
}

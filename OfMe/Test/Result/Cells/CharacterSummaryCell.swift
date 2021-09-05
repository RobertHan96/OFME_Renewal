//
//  CharacterSummaryCell.swift
//  OfMe
//
//  Created by HanaHan on 2021/09/05.
//

import UIKit
import Kingfisher

class CharacterSummaryCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var backgroundSeparatorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func configure(data: TestMyResult) {
        titleLabel.text = data.name
        subTitleLabel.makeHightledText(all: data.subName, for: data.subName)
        descriptionLabel.text = data.description
        setImageFromUrl(imgURL: data.url)
    }
    
    private func setupUI() {
        titleLabel.textColor = .borderColor
        subTitleLabel.textColor = .gray2
        descriptionLabel.textColor = .gray2
        backgroundSeparatorView.backgroundColor = .endCharacterBtnBackground
    }
    
    private func setImageFromUrl(imgURL: String) {
        DispatchQueue.main.async() {
            if let url = URL(string: imgURL) {
                self.characterImage.kf.setImage(with: url)
            }
        }
    }
}

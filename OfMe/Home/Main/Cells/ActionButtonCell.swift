//
//  ActionButtonCell.swift
//  OfMe
//
//  Created by HanaHan on 2021/08/31.
//

import UIKit

class ActionButtonCell: UICollectionViewCell {
    @IBOutlet weak var actionNameLabel: UILabel!
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var actionImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    func configure(actionName: String, isSelected: Bool) {
        actionImage.image = UIImage(named: actionName)
        actionNameLabel.text = Action(name: actionName).getNameForLabel()

        if isSelected {
            selectedHighLightEffect()
        } else {
            setupUI()
        }
    }
    
    private func selectedHighLightEffect() {
        imageContainerView.layer.borderColor = UIColor.ofMeColor.cgColor
        actionNameLabel.textColor = .ofMeColor
    }

    private func setupUI() {
        actionNameLabel.textColor = .gray2
        imageContainerView.layer.borderWidth = 1
        imageContainerView.layer.borderColor = UIColor.actionImageBorderColor.cgColor
        imageContainerView.layer.cornerRadius = imageContainerView.frame.height * 0.5
    }
}

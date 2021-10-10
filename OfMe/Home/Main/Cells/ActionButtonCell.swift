//
//  ActionButtonCell.swift
//  OfMe
//
//  Created by HanaHan on 2021/08/31.
//

import UIKit

class ActionButtonCell: UICollectionViewCell {
    @IBOutlet weak var actionNameLabel: UILabel!
    @IBOutlet weak var actionImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(actionName: String) {
        actionImage.image = UIImage(named: actionName)
        actionNameLabel.text = Action(name: actionName).getNameForLabel()
        actionImage.layer.borderWidth = 1
        actionImage.layer.borderColor = UIColor.gray.cgColor
        actionImage.layer.cornerRadius = actionImage.frame.height * 0.5
    }
}

//
//  ActionButtonCell.swift
//  OfMe
//
//  Created by HanaHan on 2021/08/31.
//

import UIKit

class ActionButtonCell: UICollectionViewCell {
    @IBOutlet weak var actionName: UILabel!
    @IBOutlet weak var actionImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(actionName: String) {
        
    }
}

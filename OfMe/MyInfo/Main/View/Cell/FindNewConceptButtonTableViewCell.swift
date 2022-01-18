//
//  FindNewConceptButtonTableViewCell.swift
//  OfMe
//
//  Created by HanaHan on 2022/01/18.
//

import UIKit

class FindNewConceptButtonTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        self.contentView.layer.cornerRadius = 6
        self.contentView.backgroundColor = .ofMeColor
    }
}

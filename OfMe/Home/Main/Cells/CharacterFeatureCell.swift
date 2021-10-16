//
//  CharacterFeatureCell.swift
//  OfMe
//
//  Created by HanaHan on 2021/08/30.
//

import UIKit

class CharacterFeatureCell: UICollectionViewCell {
    @IBOutlet weak var featureName: UILabel!
    @IBOutlet weak var featureBorderView: UIView!
    @IBOutlet weak var featureDescription: PaddingLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func configure(feature: String?, data: HomeMainResult?) {
        
        if let characterFeature = feature, let characterInfo = data {
            featureName.makeHightledText(all: "\(characterFeature.getFeatureNameForLable)을 알려줘 !", for: characterFeature.getFeatureNameForLable)
            featureDescription.text = characterInfo.data?[characterFeature]
        }
    }
    
    private func setupUI() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.characterFeatureCellGrayBackground.cgColor
        self.backgroundColor = .characterFeatureCellGrayBackground
        featureBorderView.backgroundColor = .characterFeatureCellBackground
    }

}

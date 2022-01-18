//
//  TableViewHeaderCell.swift
//  OfMe
//
//  Created by HanaHan on 2022/01/03.
//

import UIKit

class NewEmptyConceptHistoryTableViewCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var informLabel: UILabel!
    @IBOutlet weak var conceptSugesstionBtn: UIButton!
    @IBOutlet weak var coachmarkBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        containerView.backgroundColor = .historyTimeViewBackgroundColor
        informLabel.textColor = .timeLabelTextColor
        conceptSugesstionBtn.titleLabel?.textColor = .white
        conceptSugesstionBtn.titleLabel?.font = UIFont.Notos(.bold, size: 16)
        conceptSugesstionBtn.semanticContentAttribute = .forceRightToLeft
        conceptSugesstionBtn.layer.cornerRadius = 20
        conceptSugesstionBtn.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMinXMaxYCorner)
        coachmarkBtn.titleLabel?.font = UIFont.Notos(.bold, size: 12)
        coachmarkBtn.titleLabel?.numberOfLines = 2
        coachmarkBtn.titleLabel?.textAlignment = .center
        coachmarkBtn.titleLabel?.textColor = . typoBlack
        coachmarkBtn.titleLabel?.makeConceptSuggestionCoachmarkHighlightedText(all: "지금 바로 컨셉을\n추천받아보세요!", boldText: "컨셉", colorBackgroundText: "추천받아보세요", colorBackgroundFont: UIFont.Notos(.medium, size: 12), boldFont: UIFont.Notos(.bold, size: 12), normalFont: UIFont.Notos(.medium, size: 12))
    }
    
    
    @IBAction func getSuggestionConcept(_ sender: UIButton) {
        // 컨셉 추천 (2번째 탭으로 이동)
    }
    
}


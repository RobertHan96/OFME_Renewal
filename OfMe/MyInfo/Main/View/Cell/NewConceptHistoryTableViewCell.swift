//
//  NewConceptHistoryTableViewCell.swift
//  OfMe
//
//  Created by HanaHan on 2022/01/03.
//

import UIKit

class NewConceptHistoryTableViewCell: UITableViewCell {
    @IBOutlet weak var timeInfoView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var leftBorderView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var starRatingView: UIView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterFeatureLabel: UILabel!
    @IBOutlet weak var charactorImage: UIImageView!
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func configure() {
        // 이름, 특성, 캐릭터 이미지, 별점 설정
        // 별점은 for문 돌리면서 이미지 빈칸을 채우는 방식
    }
    
    private func setupUI() {
        timeInfoView.layer.cornerRadius = 6
        timeInfoView.backgroundColor = .historyTimeViewBackgroundColor
        timeLabel.textColor = .timeLabelTextColor
        leftBorderView.backgroundColor = .historyTimeViewBackgroundColor
        containerView.cornerRadius = 6
        containerView.backgroundColor = .white
        containerView.layer.masksToBounds = false
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 1, height: 4)
        containerView.layer.shadowRadius = 3
        containerView.layer.shadowOpacity = 0.3
        characterNameLabel.textColor = .mainBlue
        characterFeatureLabel.textColor = .typoBlack
        characterFeatureLabel.backgroundColor = .endCharacterBtnBackground
        starRatingView.layer.cornerRadius = 6
        starRatingView.backgroundColor = .endCharacterBtnBackground
    }
    
}

//
//  NewMyPageTableViewCell.swift
//  OfMe
//
//  Created by HanaHan on 2022/01/03.
//

import UIKit

class NewMyPageTableViewCell: UITableViewCell {
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var infoDetailButton: UIButton!
    @IBOutlet weak var bottomInfoView: UIView!
    @IBOutlet weak var containerBorderView: UIView!
    @IBOutlet weak var currentCharacterTitle: UILabel!
    @IBOutlet weak var currentCharacterLabel: UILabel!
    @IBOutlet weak var currentPointTitle: UILabel!
    @IBOutlet weak var currentPointLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func configure() {
        // 유저이름 하이라이트 처리
        //        포인트, 캐릭터 정보 업데이트
    }
    
    private func setupUI() {
        let userName = "오브미"
        userNameLabel.makeMypageUserNameHightledText(all: "좋은 하루 보내세요!\n\(userName)", for: "좋은 하루 보내세요!")
        infoDetailButton.backgroundColor = .profileDetailButtonBackgroundColor
        infoDetailButton.layer.cornerRadius = 4
        infoDetailButton.titleLabel?.textColor = .white
        infoDetailButton.titleLabel?.textColor = .conceptResultCellBackground
        containerBorderView.backgroundColor = .borderColor
        bottomInfoView.layer.cornerRadius = 6
        bottomInfoView.backgroundColor = .white
        currentPointTitle.backgroundColor = .endCharacterBtnBackground
        currentCharacterTitle.backgroundColor = .endCharacterBtnBackground
        currentPointLabel.textColor = .typoBlack
        currentCharacterLabel.textColor = .typoBlack
        bottomInfoView.layer.shadowColor = UIColor.black.cgColor
        bottomInfoView.layer.shadowOffset = CGSize(width: 0, height: 4)
        bottomInfoView.layer.shadowOpacity = 0.3
    }
    
}

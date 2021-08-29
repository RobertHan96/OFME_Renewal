//
//  TimeInfoCell.swift
//  OfMe
//
//  Created by HanaHan on 2021/08/22.
//

import UIKit

// 종료 버튼 선택시 API 호출을 위한 protocol
protocol TimeInfoCellDelegate {
    func endButtonDidCliikd()
}

class TimeInfoCell: UITableViewCell {
    @IBOutlet weak var timeNameLabel: UILabel!
    @IBOutlet weak var endCharacterBtn: UIButton!
    var delegate: TimeInfoCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(name: String?, time: String?) {
        if let userTime = time {
            timeNameLabel.makeHightledText(all: "함께한지 \(userTime)", for: userTime)
            endCharacterBtn.isHidden = false
            endCharacterBtn.makeSmallRoundedButtnon(
                "종료",
                titleColor: .endCharacterBtnTitle,
                borderColor: UIColor.endCharacterBtnBorder.cgColor,
                backgroundColor: .endCharacterBtnBackground)
        }
        
        if let userName = name {
            timeNameLabel.makeHightledText(all: "\(userName)! 안녕하세요", for: userName)
            endCharacterBtn.isHidden = true
        }
    }
    
    private func setupUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
    }
    
}

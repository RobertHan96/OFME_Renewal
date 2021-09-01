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
    
    @IBAction func endCharacter(_ sender: UIButton) {
        delegate?.endButtonDidCliikd()
    }
    
    func configure(name: String?, time: Int?) {
        if let userTime = time {
            let conceptTime = ConcpetTimeModel(userTime: 1440)
            
            timeNameLabel.makeHightledText(all: "함께한지 \(conceptTime.getTimeText)", for: conceptTime.getTimeOnly)
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
    
    private func getReadableTime(userTime: Int) -> String {
        return  "\(userTime/60/24)"
    }
    
}


struct ConcpetTimeModel {
    var userTime: Int
    
    var hour: Int {
        return userTime / 60
    }
    var minute: Int {
        return userTime % 60
    }
    
    var day: Int {
        return userTime/60/24
    }
    
    var getTimeOnly: String {
        if userTime > 1440 {
            return "\(day)"
        }
        return "\(hour.mmHour):\(minute.mmMinute)"
    }
    
    var getTimeText: String {
        if userTime > 1440 {
            return "\(day)일"
        }
        return "\(hour.mmHour):\(minute.mmMinute)"
    }
}

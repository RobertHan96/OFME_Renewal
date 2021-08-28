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
    @IBOutlet weak var CharacterTimeLabel: UILabel!
    @IBOutlet weak var endCharacterBtn: UIButton!
    var delegate: TimeInfoCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // 색상, 버튼 UI 설정
    private func setupUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 10

    }
    
}

//
//  ConceptResultSummaryCell.swift
//  OfMe
//
//  Created by HanaHan on 2021/09/03.
//

import UIKit

class ConceptResultSummaryCell: UITableViewCell {
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupUI() {
        self.backgroundColor = .conceptResultCellBackground
    }
    
    func configure(time: Int) {
        let hour = time / 60
        let minute = time % 60
        let timeText = "\(hour > 0 ? "\(hour)시간 \(minute)분" : "\(minute)분")"
        timeLabel.conceptResultmakeHightledText(all: "우리가 함께한 시간\n 총 \(timeText)", subText: "우리가 함께한 시간", totalText: "총", highlightText: "\(timeText)", hitligthedFont: .Notos(.bold, size: 18), normalFont: .Notos(.regular, size: 12))
        pointLabel.makeHightledText(all: "예상 획득 리워드는 5P 입니다 !", for: "5P", font: .Notos(.bold, size: 12))
    }
}

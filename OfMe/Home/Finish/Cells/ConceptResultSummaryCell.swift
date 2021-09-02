//
//  ConceptResultSummaryCell.swift
//  OfMe
//
//  Created by HanaHan on 2021/09/03.
//

import UIKit

class ConceptResultSummaryCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI(time: Int) {
        //        let hour = time / 60
        //        time = time % 60
        //        let timeText = "\(hour > 0 ? "\(hour)시간 \(time)분" : "\(time)분")"
        //        timeLabel.makeHightledText(all: "우리가 함께한 시간    \(timeText)", for: "\(timeText)")
        //        pointLabel.makeHightledText(all: "예상포인트 5p", for: "5p", font: .Notos(.regular, size: 11))
    }
    
}

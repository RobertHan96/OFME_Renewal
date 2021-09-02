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
    
    func configure(time: Int) {
                let hour = time / 60
                let minute = time % 60
                let timeText = "\(hour > 0 ? "\(hour)시간 \(minute)분" : "\(minute)분")"
                timeLabel.makeHightledText(all: "우리가 함께한 시간\n    \(timeText)", for: "\(timeText)")
                pointLabel.makeHightledText(all: "예상포인트 5p", for: "5p", font: .Notos(.regular, size: 11))
    }
    
}

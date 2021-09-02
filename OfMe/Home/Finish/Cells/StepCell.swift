//
//  FirstStepCell.swift
//  OfMe
//
//  Created by HanaHan on 2021/09/03.
//

import UIKit

class StepCell: UITableViewCell {
    @IBOutlet weak var stepTitle: UILabel!
    @IBOutlet weak var stepDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(step: Int) {
        if step == 3 {
            stepTitle.text = "STEP\(step - 1)"
            stepDescription.text = "오늘의 일상과 감정을\nQ&A에 기록해보세요 !"
        }
    }
    
}

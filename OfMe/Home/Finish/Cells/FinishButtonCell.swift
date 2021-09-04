//
//  FinishButtonCell.swift
//  OfMe
//
//  Created by HanaHan on 2021/09/03.
//

import UIKit

protocol FinishButtonCellDelegate {
    func ratingLaterButtonDidClicked()
    func endConceptButtonDidClicked(isValidEndRequest: Bool)
}
class FinishButtonCell: UITableViewCell {
    @IBOutlet weak var ratingLaterButton: UIButton!
    @IBOutlet weak var endConceptButton: UIButton!
    @IBOutlet weak var infromTextLabel: UILabel!
    var delegate: FinishButtonCellDelegate?
    var idx: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupUI() {
        endConceptButton.backgroundColor = .ofMeColor
    }
    
    @IBAction func endConceptButtonDidClicked(_ sender: UIButton) {
        if idx > 0 {
            endConceptButton.isUserInteractionEnabled = true
            delegate?.endConceptButtonDidClicked(isValidEndRequest: true)
        } else {
            endConceptButton.isUserInteractionEnabled = false
        }
    }
    @IBAction func ratingLaterButtonDidClicked(_ sender: UIButton) {
        delegate?.ratingLaterButtonDidClicked()
    }
}

extension FinishButtonCell: HomeFinishViewControllerDelegate {
    func starRatingDidClicked(ratingPoint: Int) {
        idx = ratingPoint
    }
}

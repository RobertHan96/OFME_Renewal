//
//  ConceptSugesstionCell.swift
//  OfMe
//
//  Created by HanaHan on 2021/08/25.
//

import UIKit


protocol ConceptSugesstionCellDelegate{
    func conceptSugesstionButtonDidClicked()
}

class ConceptSugesstionCell: UITableViewCell {
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var infroTetx: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var getConceptSugesstion: UIButton!
    var delegate: ConceptSugesstionCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupUI() {
        self.backgroundColor = .clear
    }
    
    @IBAction func conceptSugesstionClicked(_ sender: UIButton) {
        
    }
}

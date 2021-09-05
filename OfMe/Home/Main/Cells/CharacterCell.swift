//
//  CharacterCell.swift
//  OfMe
//
//  Created by HanaHan on 2021/08/22.
//

import UIKit
import Kingfisher

class CharacterCell: UITableViewCell {
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var characterImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func confgirue(imageUrl: String) {
        setCharacterImage(imageUrl: imageUrl)
    }

    private func setupUI() {
        backgroundImage.layer.cornerRadius = 10
        backgroundImage.clipsToBounds = true
        self.backgroundColor = .clear
    }
    
    
    private func setCharacterImage(imageUrl: String) {
        DispatchQueue.main.async() {
            if let url = URL(string: imageUrl) {
                
                UIView.transition(with: self.characterImage,
                                  duration: 0.75,
                                  options: .transitionCrossDissolve,
                                  animations: { self.characterImage.kf.setImage(with: url) },
                                  completion: nil)
            }
        }
    }
}

//
//  CharacterInfoCell.swift
//  OfMe
//
//  Created by HanaHan on 2021/08/22.
//

import UIKit

class CharacterInfoCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    let pageControl = UIPageControl()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // TableView -> CollectionVeiw 데이터 주입 메소드
    func setupCollectionViewDataSource() {
        
    }

    // 컬렉션뷰 셋업, 데이터 주입
    private func setupUI() {
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        
    }
    
    private func setupPageControll() {
        
    }
    
}

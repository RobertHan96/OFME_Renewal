//
//  CharacterInfoCell.swift
//  OfMe
//
//  Created by HanaHan on 2021/08/22.
//

import UIKit

class CharacterInfoCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControll: UIPageControl!

    let list = [UIColor.red, UIColor.green, UIColor.blue, UIColor.gray, UIColor.black]
    var characterInfo: HomeMainResult? { didSet {
        collectionView.reloadData()
    }}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(userConcept: HomeMainResult?) {
        characterInfo = userConcept
    }

    private func setupUI() {
        self.backgroundColor = .clear
        setupCollectionView()
        setupPageControll()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(UINib.init(nibName: "CharacterFeatureCell", bundle: nil), forCellWithReuseIdentifier: "characterFeature")
        setupFlowLayout()
    }
    
    private func setupFlowLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: collectionView.layer.bounds.width
                                     , height: 138)
        flowLayout.minimumLineSpacing = 0.0
        flowLayout.minimumInteritemSpacing = 0.0
        collectionView.collectionViewLayout = flowLayout
    }

    private func setupPageControll() {
        pageControll.numberOfPages = list.count
        pageControll.currentPage = 0
        pageControll.pageIndicatorTintColor = UIColor.systemGray
        pageControll.currentPageIndicatorTintColor = UIColor.black
    }
    
}

// 고정된 값이 아닌 미리 받아온 데이터 기반으로 cell, cell size 초기화
extension CharacterInfoCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "characterFeature", for: indexPath as IndexPath) as? CharacterFeatureCell else { return UICollectionViewCell() }
        cell.backgroundColor = list[indexPath.row]
        cell.configure(feature: "", description: "")

        return cell
    }
}

extension CharacterInfoCell: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.bounds.size.width
        // 좌표보정을 위해 절반의 너비를 더해줌
        let x = scrollView.contentOffset.x + (width/2)
        
        let newPage = Int(x / width)
        if pageControll.currentPage != newPage {
            pageControll.currentPage = newPage
        }
    }
}

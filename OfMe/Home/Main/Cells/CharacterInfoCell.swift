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

    func configure(testResult: TestMyResult) {
        let feature = CharacterFeatures(id: testResult.id, name: testResult.name, advantage: testResult.advantage, habit: testResult.habit, behavior: testResult.behavior, value: testResult.value, music: testResult.music, isFirstMain: "X")
        let data = HomeMainResult(conceptProgressCheck: "O", nickname: "", image: [testResult.url], data: feature, clientTime: nil)
        characterInfo = data
    }

    private func setupUI() {
        self.backgroundColor = .clear
        setupCollectionView()
        setupPageControll()
    }

    private func setupTestResultUI() {
        self.layer.borderWidth = 1
        self.borderColor = .characterFeatureCellBorder
        self.layer.cornerRadius = 10
    }

    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(UINib.init(nibName: CellManager.CharacterFeatureCellName, bundle: nil), forCellWithReuseIdentifier: CellManager.CharacterFeatureCellIdentifier)
        collectionView.register(UINib.init(nibName: CellManager.CharacterFavoriteMusicCellIName, bundle: nil), forCellWithReuseIdentifier: CellManager.CharacterFavoriteMusicCellIdentifier)
        setupFlowLayout()
    }
    
    private func setupFlowLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: collectionView.layer.bounds.width - 10
                                     , height: 171)
        flowLayout.minimumLineSpacing = 10.0
        flowLayout.minimumInteritemSpacing = 0.0
        collectionView.collectionViewLayout = flowLayout
    }

    private func setupPageControll() {
        pageControll.numberOfPages = CharacterFeatureCellModel.totalCharacterFeature
        pageControll.currentPage = 0
        pageControll.pageIndicatorTintColor = UIColor.systemGray
        pageControll.currentPageIndicatorTintColor = UIColor.black
    }
    
}

// 고정된 값이 아닌 미리 받아온 데이터 기반으로 cell, cell size 초기화
extension CharacterInfoCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        CharacterFeatureCellModel.totalCharacterFeature
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch CharacterFeatureCellModel.characterFeatures[indexPath.row] {
        case CharacterFeatureParsingName.music.rawValue:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellManager.CharacterFavoriteMusicCellIdentifier, for: indexPath as IndexPath) as? CharacterFavoriteMusicCell else { return UICollectionViewCell() }
            cell.configure(feature: CharacterFeatureCellModel.characterFeatures[indexPath.row], data: characterInfo)
            
            return cell
            
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellManager.CharacterFeatureCellIdentifier, for: indexPath as IndexPath) as? CharacterFeatureCell else { return UICollectionViewCell() }
            cell.configure(feature: CharacterFeatureCellModel.characterFeatures[indexPath.row], data: characterInfo)

            return cell
        }
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

//
//  StarRatingCell.swift
//  OfMe
//
//  Created by HanaHan on 2021/09/03.
//

import UIKit

class StarRatingCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    private var idx: Int = -1

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupUI() {
        setupCollectionView()
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: StarCell.identifier, bundle: nil), forCellWithReuseIdentifier: StarCell.identifier)
    }
}

extension StarRatingCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StarCell.identifier, for: indexPath) as? StarCell else {
            return UICollectionViewCell()
        }
        cell.updateUI(row: indexPath.row, idx: idx)
        cell.backgroundColor = .purple
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
}

extension StarRatingCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        idx = indexPath.row
        if idx != -1 {
//            delegate?.starRatingDidClicked()
        }
        collectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 44, height: 44)
    }
}

//
//  StarRatingCell.swift
//  OfMe
//
//  Created by HanaHan on 2021/09/03.
//

import UIKit

class StarRatingCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

//extension HomeFinishViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StarCell.identifier, for: indexPath) as? StarCell else {
//            return UICollectionViewCell()
//        }
//        cell.updateUI(row: indexPath.row, idx: idx)
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 1
//    }
//}
//
//extension HomeFinishViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        idx = indexPath.row
//        if idx != -1 {
//            nextButton.isUserInteractionEnabled = true
//        }
//        collectionView.reloadData()
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 44, height: 44)
//    }

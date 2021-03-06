//
//  StarRatingCell.swift
//  OfMe
//
//  Created by HanaHan on 2021/09/03.
//

import UIKit

protocol StarRatingCellDelegate {
    func starRatingDidClicked(ratingPoint: Int)
}

class StarRatingCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var delegate: StarRatingCellDelegate?
    private var idx: Int = -1

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupUI() {
        self.backgroundColor = .endCharacterBtnBackground
        titleLabel.backgroundColor = .textHighlightColor
        setupCollectionView()
    }
    
    func setupCollectionView() {
        collectionView.backgroundColor = .endCharacterBtnBackground
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
            delegate?.starRatingDidClicked(ratingPoint: idx + 1)
        }
        collectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 44, height: 44)
    }
}

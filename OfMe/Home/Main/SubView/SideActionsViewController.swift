//
//  SideActionsViewController.swift
//  OfMe
//
//  Created by HanaHan on 2021/08/31.
//

import UIKit

protocol SideActionMenuDelegate{
    func actionButtonDidCliikd(actionIndexPath: Int)
}

class SideActionsViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var sidemenuTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var deleagte: SideActionMenuDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .clear
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 10
        setupCollectionView()
        setupFlowLayout()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(UINib.init(nibName: CellManager.ActionButtonCellName, bundle: nil), forCellWithReuseIdentifier: CellManager.ActionButtonCellIdentifier)
        setupFlowLayout()
    }
    
    private func setupFlowLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 26
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.itemSize = CGSize(width: collectionView.layer.bounds.width / 4
                                     , height: collectionView.layer.bounds.height / 4)
        collectionView.collectionViewLayout = flowLayout
    }

}

extension SideActionsViewController: SideActionMenuDelegate {
    func actionButtonDidCliikd(actionIndexPath: Int) {
        deleagte?.actionButtonDidCliikd(actionIndexPath: actionIndexPath)
    }
}

extension SideActionsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellManager.ActionButtonCellIdentifier, for: indexPath as IndexPath) as? ActionButtonCell else { return UICollectionViewCell() }
        cell.configure(actionName: Action.actions[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        deleagte?.actionButtonDidCliikd(actionIndexPath: indexPath.row)
    }
}

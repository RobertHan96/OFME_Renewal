import UIKit

class CategoryAdapter: NSObject {
    private weak var collectionView: UICollectionView!
    private var data: [TestMyCategory] = []
    private var idx: Int = -1
    private var selected: ((_ at: TestMyCategory?) -> Void)?
    
    init(of collectionView: UICollectionView, data: [TestMyCategory] ,selected: @escaping (_ at: TestMyCategory?) -> Void) {
        super.init()
        self.data = data
        self.collectionView = collectionView
        self.collectionView.register(
            UINib(nibName: CategoryCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        self.selected = selected
        setDelegate()
    }
    
    func setDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}

extension CategoryAdapter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoryCollectionViewCell.identifier,
                for: indexPath) as? CategoryCollectionViewCell else { return UICollectionViewCell() }
        cell.updateUI(data: data[indexPath.row], index: idx, row: indexPath.row)
        return cell
    }
    
}

extension CategoryAdapter: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selected = selected else { return }
        if idx != indexPath.row {
            idx = indexPath.row
            collectionView.reloadData()
            selected(data[indexPath.row])
        } else {
            idx = -1
            collectionView.reloadData()
            selected(nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 - 27.5, height: 95)
    }
}

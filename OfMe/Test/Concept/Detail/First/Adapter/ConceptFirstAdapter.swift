import UIKit

class ConceptFirstAdapter: NSObject {
    private var idx: Int = -1
    private var data: [TestConceptFirst] = []
    private weak var collectionView : UICollectionView!
    private var selected: ((_ at: Int) -> Void)?
    
    init(of collectionView: UICollectionView, data: [TestConceptFirst], selected: @escaping (_ at: Int) -> Void) {
        super.init()
        self.data = data
        self.collectionView = collectionView
        self.selected = selected
        self.collectionView.register(
            UINib(nibName: ConceptTestCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: ConceptTestCollectionViewCell.identifier)
        self.collectionView.register(TestConceptHeader.self,
                                     forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                     withReuseIdentifier: TestConceptHeader.identifer)
        
        setDelegate()
    }
    
    func setDelegate() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension ConceptFirstAdapter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ConceptTestCollectionViewCell.identifier,
                for: indexPath) as? ConceptTestCollectionViewCell else { return UICollectionViewCell() }
        cell.updateUI(idx: idx, row: indexPath.row, title: data[indexPath.row].keyword)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: TestConceptHeader.identifer, for: indexPath) as! TestConceptHeader
        view.titleLabel.text = " 1 / 3 "
        view.descriptLabel.text = "아래 나열된 단어들 중 하나를 선택해주세요"
        return view
    }
}

extension ConceptFirstAdapter: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selected = selected else { return }
        if idx != indexPath.row { idx = indexPath.row } else { idx = -1 }
        collectionView.reloadData()
        print("LOG", idx)
        selected(idx)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2-27.5, height: 100)
    }
}

import UIKit

class ConceptSecondAdapter: NSObject {
    private var data: TestConceptSecond?
    private var idx: Int = -1
    private weak var collectionView : UICollectionView!
    private var selected: ((_ at: Int) -> Void)?
    
    init(of collectionView: UICollectionView, data: TestConceptSecond, selected: @escaping (_ at: Int) -> Void) {
        super.init()
        self.data = data
        self.collectionView = collectionView
        self.selected = selected
        self.collectionView.register(
            UINib(nibName: ConceptTestCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: ConceptTestCollectionViewCell.identifier)
        self.collectionView.register(
            UINib(nibName: TestConceptDescriptCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: TestConceptDescriptCollectionViewCell.identifier)
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

extension ConceptSecondAdapter: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: TestConceptDescriptCollectionViewCell.identifier,
                    for: indexPath) as? TestConceptDescriptCollectionViewCell else { return UICollectionViewCell() }
            if let data = data {
                cell.updateUI(text: data.question, word: data.highlight)
            }
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: ConceptTestCollectionViewCell.identifier,
                    for: indexPath) as? ConceptTestCollectionViewCell else { return UICollectionViewCell() }
            if let data = data {
                cell.updateUI(idx: idx, row: indexPath.row, data: data)
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: TestConceptHeader.identifer, for: indexPath) as! TestConceptHeader
        view.titleLabel.text = " 2 / 3 "
        view.descriptLabel.text = "아래 선택지 중 하나를 선택해주세요"
        return view
    }
}

extension ConceptSecondAdapter: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row > 0 {
            guard let selected = selected else { return }
            if idx != 0 {
                if idx != indexPath.row { idx = indexPath.row } else { idx = -1 }
                collectionView.reloadData()
                selected(idx)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 106)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.row {
        case 0:
            return CGSize(width: collectionView.frame.width-40, height: 137)
        default:
            return CGSize(width: collectionView.frame.width-40, height: 56)
        }
    }
}

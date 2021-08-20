import UIKit

class ArchiveMainAdapter: NSObject {
    private let dataManager = DiaryDataManager()
    private weak var collectionView: UICollectionView!
    private weak var vc: ArchiveMainViewController!
    private var data: [DiaryGet] = []
    
    init(of collectionView: UICollectionView, data: [DiaryGet], vc: ArchiveMainViewController) {
        super.init()
        self.vc = vc
        self.data = data
        self.collectionView = collectionView
        self.collectionView.register(UINib(nibName: DiaryViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DiaryViewCell.identifier)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    func updateData(data: [DiaryGet]) {
        self.data = data
        collectionView.reloadData()
    }
    
    @objc func fix(_ sender: UIButton) {
        print(data[sender.tag])
        let vc = ArchiveWriteViewController(data: data[sender.tag])
        self.vc.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func delete(_ sender: UIButton) {
        print("delete")
        dataManager.deleteDiary(idx: data[sender.tag].id) {
            if $0 == 1000 {
                print($0)
                self.data.remove(at: sender.tag)
                self.collectionView.reloadData()
            } else {
                self.vc.presentAlert(title: "다시 시도해주시기 바랍니다.")
            }
        }
    }
    
}

extension ArchiveMainAdapter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: DiaryViewCell.identifier,
                for: indexPath) as? DiaryViewCell else { return UICollectionViewCell() }
        cell.updateUI(data: data[indexPath.row])
        [cell.fixButton, cell.deleteButton].forEach {
            $0.tag = indexPath.row
        }
        cell.fixButton.addTarget(self, action: #selector(fix), for: .touchDown)
        cell.deleteButton.addTarget(self, action: #selector(delete), for: .touchDown)
        return cell
    }
}

extension ArchiveMainAdapter: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width-30, height: collectionView.frame.height-50)
    }
}

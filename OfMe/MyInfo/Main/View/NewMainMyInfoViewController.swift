//
//  NewMainMyInfoViewController.swift
//  OfMe
//
//  Created by HanaHan on 2022/01/03.
//

import UIKit

class NewMainMyInfoViewController: UIViewController {
    @IBOutlet weak var myInfoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        myInfoTableView.estimatedRowHeight = 250
//        TODO
//        3) 버튼 cell 디자인 + 제작 : 총 2개 (새로운 컨셉 만나보기, 컨셉 추천 받기)
//        4) 아직 히스토리가 없습니다! cell
//        UI 테스트 끝나면 동적 높이 할당으로 원복 필요
//        myInfoTableView.rowHeight = UITableView.automaticDimension
        myInfoTableView.rowHeight = 30
        setupTableView()
    }
    
    private func setupTableView() {
        myInfoTableView.delegate = self
        myInfoTableView.dataSource = self
        myInfoTableView.backgroundColor = .clear
        myInfoTableView.register(UINib.init(nibName: MyInfoTableViewCellManager.MyPageCellName, bundle: nil), forCellReuseIdentifier: MyInfoTableViewCellManager.MyPageCellIdentifier) // cell height 273
        myInfoTableView.register(UINib.init(nibName: MyInfoTableViewCellManager.TableViewHeaderCellName, bundle: nil), forCellReuseIdentifier: MyInfoTableViewCellManager.TableViewHeaderCellIdentifier) // cell height 49
        myInfoTableView.register(UINib.init(nibName: MyInfoTableViewCellManager.ConceptHistoryCellName, bundle: nil), forCellReuseIdentifier: MyInfoTableViewCellManager.ConceptHistoryCellIdentifier) // cell height 250
        myInfoTableView.register(UINib.init(nibName: MyInfoTableViewCellManager.NewEmptyConceptHistoryCellName, bundle: nil), forCellReuseIdentifier: MyInfoTableViewCellManager.NewEmptyConceptHistoryCellIdentifier) // cell height 100
        myInfoTableView.register(UINib.init(nibName: MyInfoTableViewCellManager.FindNewConceptButtonCellName, bundle: nil), forCellReuseIdentifier: MyInfoTableViewCellManager.FindNewConceptButtonCellIdentifier) // cell height 30
    }

}

extension NewMainMyInfoViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 273
        case 1:
            return 49
        case 2:
            return 250
        case 3:
            return 100
        default:
            return 30
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0: // 유저 프사, 정보보기 Cell
            guard let myPageCell = myInfoTableView.dequeueReusableCell(withIdentifier: MyInfoTableViewCellManager.MyPageCellIdentifier) as? NewMyPageTableViewCell else{ return UITableViewCell() }
            return myPageCell
        case 1: // 컨셉히스토리 제목, 총 개수 표시 Cell
            guard let tablewViewHeaderCell = myInfoTableView.dequeueReusableCell(withIdentifier: MyInfoTableViewCellManager.TableViewHeaderCellIdentifier) as? TableViewHeaderCell else{ return UITableViewCell() }
            return tablewViewHeaderCell
        case 2: // 캐릭터 컨셉히스토리 Cell
            guard let conceptHistoryCell = myInfoTableView.dequeueReusableCell(withIdentifier: MyInfoTableViewCellManager.ConceptHistoryCellIdentifier) as? NewConceptHistoryTableViewCell else{ return UITableViewCell() }
            return conceptHistoryCell
        case 3: // 컨셉 히스토리 있는 경우 컨셉 추천 받기 버튼 Cell
            guard let findNewconceptButtonCell = myInfoTableView.dequeueReusableCell(withIdentifier: MyInfoTableViewCellManager.FindNewConceptButtonCellIdentifier) as? FindNewConceptButtonTableViewCell else{ return UITableViewCell() }
            return findNewconceptButtonCell
        default: // 컨셉 히스토리 여부에 따라 -> 컨셉 추천받기 버튼 or 히스토리 없음 Cell 표시
            // 버튼 액션 대신 didSelectItemRow 했을때 컨셉 테스트 화면 (2번째 탭)으로 이동
            guard let emptyConceptCell = myInfoTableView.dequeueReusableCell(withIdentifier: MyInfoTableViewCellManager.NewEmptyConceptHistoryCellIdentifier) as? NewEmptyConceptHistoryTableViewCell else{ return UITableViewCell() }
            return emptyConceptCell
        }
    }
    
}

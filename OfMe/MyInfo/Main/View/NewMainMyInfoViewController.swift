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
        myInfoTableView.estimatedRowHeight = 400
//        TODO
//        2) 캐릭터 히스토리 cell 디자인 + 제작
//        3) 버튼 cell 디자인 + 제작 : 히스토리 없을때, 있을때로 2개 제작
//        UI 테스트 끝나면 동적 높이 할당으로 원복 필요
//        myInfoTableView.rowHeight = UITableView.automaticDimension
        myInfoTableView.rowHeight = 400
        setupTableView()
    }
    
    private func setupTableView() {
        myInfoTableView.delegate = self
        myInfoTableView.dataSource = self
        myInfoTableView.backgroundColor = .clear
        myInfoTableView.register(UINib.init(nibName: MyInfoTableViewCellManager.TableViewHeaderCellName, bundle: nil), forCellReuseIdentifier: MyInfoTableViewCellManager.TableViewHeaderCellIdentifier)
        myInfoTableView.register(UINib.init(nibName: MyInfoTableViewCellManager.MyPageCellName, bundle: nil), forCellReuseIdentifier: MyInfoTableViewCellManager.MyPageCellIdentifier)
        
    }

}

extension NewMainMyInfoViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tablewViewHeaderCell = myInfoTableView.dequeueReusableCell(withIdentifier: MyInfoTableViewCellManager.TableViewHeaderCellIdentifier) as? TableViewHeaderCell else{ return UITableViewCell() }
        guard let myPageCell = myInfoTableView.dequeueReusableCell(withIdentifier: MyInfoTableViewCellManager.MyPageCellIdentifier) as? NewMyPageTableViewCell else{ return UITableViewCell() }

        return myPageCell

    }
    
    
}

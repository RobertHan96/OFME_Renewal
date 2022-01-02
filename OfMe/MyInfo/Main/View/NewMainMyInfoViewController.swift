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
        myInfoTableView.estimatedRowHeight = 700
        myInfoTableView.rowHeight = UITableView.automaticDimension
        setupTableView()
    }
    
    private func setupTableView() {
//        myInfoTableView.delegate = self
//        myInfoTableView.dataSource = self
        myInfoTableView.backgroundColor = .clear
        myInfoTableView.register(UINib.init(nibName: CellManager.TimeInfoCellName, bundle: nil), forCellReuseIdentifier: CellManager.TimeInfoCellIdentifier)
        myInfoTableView.register(UINib.init(nibName: CellManager.CharacterCellName, bundle: nil), forCellReuseIdentifier: CellManager.CharacterCellIdentifier)
        myInfoTableView.register(UINib.init(nibName: CellManager.CharacterInfoCellName, bundle: nil), forCellReuseIdentifier: CellManager.CharacterInfoCellIdentifier)
    }

}

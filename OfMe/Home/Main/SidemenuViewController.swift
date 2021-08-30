//
//  SidemenuViewController.swift
//  OfMe
//
//  Created by HanaHan on 2021/08/30.
//

import UIKit

protocol SideActionMenuDelegate{
    func waterActionButtonDidCliikd()
}

class SidemenuViewController: UIViewController {
    @IBOutlet weak var waterAction: UIButton!
    var deleagte: SideActionMenuDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {

    }

    @IBAction func waterActionBtnClicked(_ sender: UIButton) {
        deleagte?.waterActionButtonDidCliikd()
    }
}

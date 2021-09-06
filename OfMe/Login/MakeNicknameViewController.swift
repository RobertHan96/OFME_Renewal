//
//  MakeNicknameViewController.swift
//  OfMe
//
//  Created by HanaHan on 2021/09/06.
//

import UIKit

class MakeNicknameViewController: BaseViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nicknameTextFeild: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var clearTextButton: UIButton!
    @IBOutlet weak var checkDuplecatedNicknameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func setupUI() {
        self.navigationItem.setHidesBackButton(true, animated: false)
        // 조건 만족시 다음 버튼 isEnabled = True로 변경 필요
        nextButton.isEnabled = false
        clearTextButton.isHidden = true
        checkDuplecatedNicknameButton.isHidden = true
        nextButton.backgroundColor = .nicknameTextFieldColor
        checkDuplecatedNicknameButton.titleLabel?.textColor = .typoBlue
        
    }
    
    private func fetchData() {
        // 닉네임 생성 가능할 때 활성화할 이미지
        let enabledBtnBackground = UIImage(named: "next_btn_background-1")
    }
    @IBAction func checkDuplecatedNicknameButtonDidClicked(_ sender: UIButton) {
    }
    
    @IBAction func clearTextButtonDidClicked(_ sender: UIButton) {
    }
    
    @IBAction func nextButtonDidkClicked(_ sender: UIButton) {

    }
}

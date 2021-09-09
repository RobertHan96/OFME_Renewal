//
//  MakeNicknameViewController.swift
//  OfMe
//
//  Created by HanaHan on 2021/09/06.
//

import UIKit
import RxCocoa
import RxSwift

class MakeNicknameViewController: BaseViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nicknameTextFeild: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var clearTextButton: UIButton!
    @IBOutlet weak var checkDuplecatedNicknameButton: UIButton!
    let enabledBtnBackgroundImage = UIImage(named: "next_btn_background-1")
    let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        validateNickname()
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
    
    private func validateNickname() {
        nicknameTextFeild.rx.text.orEmpty
            .map { self.showTextClearButton(text: $0) }
//            .map { checkNamePolicy(text: $0)}
            .subscribe { str in
                self.checkDuplecatedNicknameButton.isHidden = false
                self.clearTextButton.isHidden = false
                print(str)
            } onError: { err in
                print(err)
            }.disposed(by: disposeBag)
    }
    
    private func showTextClearButton(text: String) -> Bool {
        if text.count < 2 || text.count > 10 {
            return false
        }
        
        return true
    }
    
    private func checkNamePolicy(text: String) -> Bool {
        // String -> Array
        let arr = Array(text)
        // 정규식 pattern. 한글, 영어, 숫자, 밑줄(_)만 있어야함
        let pattern = "^[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]$"
        if let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) {
            var index = 0
            while index < arr.count { // string 내 각 문자 하나하나 마다 정규식 체크 후 충족하지 못한것은 제거.
                let results = regex.matches(in: String(arr[index]), options: [], range: NSRange(location: 0, length: 1))
                if results.count == 0 {
                    return false
                } else {
                    index += 1
                }
            }
        }
        
        if text.count < 2 || text.count > 10 {
            return false
        }
        
        return true
    }

    private func fetchData() {
        // 닉네임 생성 가능할 때 활성화할 이미지
    }
    
    @IBAction func checkDuplecatedNicknameButtonDidClicked(_ sender: UIButton) {
        NicknameDataManager().postCheckUserNicknameDuplecated(nickname: nicknameTextFeild.text ?? "") { duplecatedResponse in
            print("LOG:", duplecatedResponse)
        }
    }
    
    @IBAction func clearTextButtonDidClicked(_ sender: UIButton) {
        nicknameTextFeild.text = nil
    }
    
    @IBAction func nextButtonDidkClicked(_ sender: UIButton) {
        NicknameDataManager().postUserNickname(nickname: nicknameTextFeild.text ?? "") { makeNicknameResponse in
            if makeNicknameResponse.code == 1000 {
                self.navigationController?.pushViewController(HomeMainViewController(), animated: false)
            } else {
                print("LOG:", makeNicknameResponse)
            }
        }
    }
}

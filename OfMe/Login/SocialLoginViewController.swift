//
//  SocialLoginViewController.swift
//  OfMe
//
//  Created by HanaHan on 2021/09/06.
//

import UIKit

class SocialLoginViewController: BaseViewController {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var kakaoLoginButton: UIButton!
    @IBOutlet weak var appleLoginButton: UIButton!
    @IBOutlet weak var termsOfServiceLabel: UILabel!
    @IBOutlet weak var termsOfServiceBackgroundView: UIView!
    var socialLoginManager: SocialLoginManager?
    
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
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "login_background")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        contentView.insertSubview(backgroundImage, at: 0)
        titleLabel.makeLoginTitleHightledText(all: "OFME\n시작해볼까요?", for: "OFME")
        termsOfServiceLabel.textColor = .gray3
        termsOfServiceBackgroundView.backgroundColor = .endCharacterBtnBackground
    }
    
    @IBAction func kakaoButtonDidClicked(_ sender: Any) {
        socialLoginManager = SocialLoginManager(self, socialLoginType: .kakao)
        socialLoginManager?.login()
    }
    
    @IBAction func appleLoginButtonDidClicked(_ sender: Any) {
        socialLoginManager = SocialLoginManager(self, socialLoginType: .apple)
        socialLoginManager?.login()
    }
}

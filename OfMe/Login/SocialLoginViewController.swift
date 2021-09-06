//
//  SocialLoginViewController.swift
//  OfMe
//
//  Created by HanaHan on 2021/09/06.
//

import UIKit
import AuthenticationServices

class SocialLoginViewController: BaseViewController {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var kakaoLoginButton: UIButton!
    @IBOutlet weak var appleLoginButton: UIButton!
    @IBOutlet weak var termsOfServiceLabel: UILabel!
    @IBOutlet weak var termsOfServiceBackgroundView: UIView!
    
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
        navigationController?.pushViewController(MakeNicknameViewController(), animated: true)
    }
    
    
    @IBAction func appleLoginButtonDidClicked(_ sender: Any) {
        tabAppleLogin()
    }
    
    func tabAppleLogin() {
        if #available(iOS 13.0, *) {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])

            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
        } else {
            self.presentAlert(title: "애플 로그인은 iOS 13.0 이상부터 가능합니다.")
        }
    }

}

@available(iOS 13.0, *)
extension SocialLoginViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    // Apple ID 연동 성공 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
            case let appleIDCredential as ASAuthorizationAppleIDCredential:
                let name = appleIDCredential.fullName?.description ?? ""
                let accessToken = String(data: appleIDCredential.identityToken!, encoding: .ascii) ?? ""
                
                LoginDataManager().postAppleLogin(token: accessToken, completion: { response in
                    print("LOG", name, accessToken, response)
                })
        default:
            self.presentAlert(title: "로그인 에러 발생")
        }
    }
        
    // Apple ID 연동 실패 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        self.presentAlert(title: "로그인 에러 발생 \(error)")
        print(error)
    }
    
    // context를 어디에 띄울지
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

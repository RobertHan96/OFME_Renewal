
//  SocialLoginManager.swift
//  OfMe
//
//  Created by HanaHan on 2021/09/09.
//
import Foundation
import UIKit
import AuthenticationServices
import KakaoSDKAuth
import KakaoSDKUser


class SocialLoginManager: NSObject {
    var loginType: SocialLoginType
    var viewController: UIViewController
    
    init(_ viewController : UIViewController, socialLoginType: SocialLoginType) {
        self.loginType = socialLoginType
        self.viewController = viewController
    }
    
    func login() {
        if loginType == .apple {
            appleLogin()
        } else {
            kakaoLogin()
        }
    }
    
    private func appleLogin() {
        if #available(iOS 13.0, *) {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])

            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
        } else {
            self.viewController.presentAlert(title: "애플 로그인은 iOS 13.0 이상부터 가능합니다.")
        }
    }
        
    private func kakaoLogin() {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    self.viewController.presentAlert(title: "카카오 정보 불러오기 실패")
                    print("LOG:\(error)")
                }
                else {
                    print("LOG:loginWithKakaoTalk() success.")
                    let accessToken = oauthToken?.accessToken ?? ""
                    LoginDataManager().postKakaoLogin(token: accessToken, completion: { response in
                        self.fetchView(response: response)
                    })
                }
            }
        }
    }
    
    private func fetchView(response: SocialLoginResponse) {
        DispatchQueue.main.async {
            if response.code == LoginDataManager.ResponseType.signIn.rawValue {
                self.viewController.navigationController?.pushViewController(MakeNicknameViewController(), animated: false)
                UserDefaults.standard.setValue(response.result?.jwt, forKey: Strings.userDefaultDeviceJwtToken)

            } else if response.code == 1000 {
                self.viewController.navigationController?.pushViewController(CustomTabBarViewController(), animated: false)
                UserDefaults.standard.setValue(response.result?.jwt, forKey: Strings.userDefaultDeviceJwtToken)
            } else {
                self.viewController.presentAlert(title: "로그인 에러 발생\n\(response.code)")
            }
        }
    }

    enum SocialLoginType {
        case kakao
        case apple
    }
}

@available(iOS 13.0, *)
extension SocialLoginManager: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    // Apple ID 연동 성공 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
            case let appleIDCredential as ASAuthorizationAppleIDCredential:
                let authToken = String(data: appleIDCredential.authorizationCode ?? Data(), encoding: .ascii) ?? ""
                LoginDataManager().postAppleLogin(token: authToken, completion: { response in
                    print("LOG", response)
                    self.fetchView(response: response)
                })
        default:
            self.viewController.presentAlert(title: "로그인 에러 발생")
        }
    }
        
    // Apple ID 연동 실패 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        self.viewController.presentAlert(title: "로그인 에러 발생")
        print(error)
    }
    
    // context를 어디에 띄울지
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.viewController.view.window!
    }
}

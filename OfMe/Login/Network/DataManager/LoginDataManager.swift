import UIKit
import Alamofire

class LoginDataManager: LoginDelegate {
    
    private enum param: String {
        case email = "email"
        case password = "password"
    }
    
    let errorText: [Int: String] = [
        2008 : "이메일을 입력해주시기 바랍니다.",
        2009 : "이메일은 30자 미만입니다.",
        2010 : "이메일 형식이 올바르지 않습니다.",
        2011 : "비밀번호를 입력해주시기 바랍니다.",
        2021 : "비밀번호는 8자에서 20자 사이 입니다.",
        3003 : "존재하지 않는 회원입니다.",
        3005 : "존재하지 않는 회원입니다.",
        3004 : "비밀번호가 올바르지 않습니다."
    ]
    
    enum ResponseType: Int {
        case signIn = 1001
        case login = 1000
    }

    func postLogin(vc: viewController, email: String, password: String, completion: @escaping (response) -> Void) {
        let parameter: Parameters = [
            param.email.rawValue : email,
            param.password.rawValue : password
        ]
        if let url = URL(string: URLString.login) {
            AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: nil)
                .validate()
                .responseDecodable(of: LoginResponse.self) { response in
                    switch response.result {
                    case .success(let result):
                        print(result)
                        completion(result)
                    case .failure(let error):
                        print("login Error: \(error.errorDescription ?? "error")")
                        completion(LoginResponse.error)
                }
            }
        }
    }
    
    func postAppleLogin(token: String, completion: @escaping (SocialLoginResponse) -> Void) {
        let parameter: Parameters = ["code":token]
        if let url = URL(string: URLString.appleLogin) {
            AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: nil)
                .validate()
                .responseDecodable(of: SocialLoginResponse.self) { response in
                    switch response.result {
                    case .success(let result):
                        print("LOG: appleLoginSucess", url, token, parameter, result)
                        completion(result)
                    case .failure(let error):
                        print("login Error: \(error.errorDescription ?? "error")", response, token )
                        completion(SocialLoginResponse.error)
                }
            }
        }
    }
    
    func postKakaoLogin(token: String, completion: @escaping (SocialLoginResponse) -> Void) {
        let parameter: Parameters = ["accessToken":token]
        if let url = URL(string: URLString.kakaoLogin) {
            AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: nil)
                .validate()
                .responseDecodable(of: SocialLoginResponse.self) { response in
                    switch response.result {
                    case .success(let result):
                        print("LOG: kakaoLoginSucess", url, token, parameter, result)
                        completion(result)
                    case .failure(let error):
                        print("login Error: \(error.errorDescription ?? "error")", response, token)
                        completion(SocialLoginResponse.error)
                    }
                }
        }
    }
}

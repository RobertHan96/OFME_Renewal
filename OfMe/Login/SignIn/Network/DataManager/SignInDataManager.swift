import UIKit
import Alamofire

class SignInDataManager: SignInProtocol {
    private enum param: String {
        case email = "email"
        case password = "password"
        case checkPassword = "checkPassword"
        case nickname = "nickname"
    }
    
    let resultText: [Int:String] = [
        2001 : "이메일을 입력해주시기 바랍니다.",
        2003 : "이메일 형식이 올바르지 않습니다.",
        2004 : "비밀번호를 입력해주시기 바랍니다.",
        2005 : "비밀번호는 8~20자 제한입니다.",
        2019 : "비밀번호 확인란을 입력해주시기 바랍니다.",
        2006 : "닉네임을 입력해주시기 바랍니다",
        2007 : "닉네임은 2~10자 제한입니다.",
        2020 : "닉네임은 한글만 입력해주시기 바랍니다",
        3001 : "중복 이메일이므로 다시 입력해주시기 바랍니다.",
        3002 : "이미 사용중인 닉네임 입니다.",
        3007 : "비밀번호 확인란과 비밀번호란이 일치하지 않습니다."
    ]
    
    let resultTag: [Int:Int] = [
        2001 : 0,
        2003 : 0,
        2004 : 1,
        2005 : 1,
        2019 : 1,
        2006 : 2,
        2007 : 2,
        2020 : 2,
        3001 : 0,
        3002 : 2,
        3007 : 1,
    ]
    
    let textFieldTag: [Int: Int] = [
        2001 : 0,
        2003 : 0,
        2004 : 1,
        2005 : 1,
        2019 : 2,
        2006 : 3,
        2007 : 3,
        2020 : 3,
        3001 : 0,
        3002 : 3,
        3007 : 2,
    ]
    
    func postSignRequest(vc: SignInViewController,
                         info: Info,
                         completion: @escaping (_ result: SignInResponse) -> Void) {
        let paramter: Parameters = [
            param.email.rawValue : info.email,
            param.password.rawValue : info.password,
            param.checkPassword.rawValue : info.password2,
            param.nickname.rawValue : info.nickName
        ]
        if let url = URL(string: URLString.signIn) {
            AF.request(url, method: .post, parameters: paramter, encoding: JSONEncoding.default, headers: nil)
                .validate()
                .responseDecodable(of: SignInResponse.self) { response in
                    switch response.result {
                    case .success(let result):
                        print(result)
                        completion(result)
                    case .failure(let error):
                        print("SignIn Error:\(error.errorDescription ?? "error")")
                        completion(SignInResponse.error)
                    }
                }
        }
    }
}

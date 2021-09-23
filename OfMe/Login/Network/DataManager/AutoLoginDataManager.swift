import UIKit
import Alamofire

class AutoLoginDataManager {
    
    func autoLogin(completion: @escaping (_ result: AutoLoginResponse) -> Void) {
        if let url = URL(string: URLString.autoLogIn) {
            let jwt = Device().getTokenInfo()
            let header: HTTPHeaders = [ "x-access-token" : jwt ]
            AF.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: header, interceptor: nil, requestModifier: nil)
                .validate()
                .responseDecodable(of: AutoLoginResponse.self) { response in
                    switch response.result {
                    case .success(let result):
                        print("LOG:자동로그인 진행",result)
                        completion(result)
                    case .failure(let error):
                        print("Auto Login: \(error.errorDescription ?? "error")")
                        completion(AutoLoginResponse.error)
                    }
                }
        } else {
            completion(AutoLoginResponse.error)
        }
        
    }
}

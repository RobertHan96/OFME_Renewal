import UIKit
import Alamofire

class AutoLoginDataManager {
    
    func autoLogin(completion: @escaping (_ result: AutoLoginResponse) -> Void) {
        if let jwt = UserDefaults.standard.object(forKey: "jwt") as? String, let url = URL(string: URLString.autoLogIn) {
            let header: HTTPHeaders = [ "x-access-token" : jwt ]
            print(jwt)
            AF.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: header, interceptor: nil, requestModifier: nil)
                .validate()
                .responseDecodable(of: AutoLoginResponse.self) { response in
                    switch response.result {
                    case .success(let result):
                        print(result)
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

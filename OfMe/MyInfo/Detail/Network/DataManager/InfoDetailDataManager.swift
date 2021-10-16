import Foundation
import Alamofire

class InfoDetailDataManager {
    func getDetail(completed: @escaping (_ at: [InfoDetail]) -> Void) {
        if let jwt = UserDefaults.standard.object(forKey: "jwt") as? String, let url = URL(string: URLString.infoDetail) {
            let header: HTTPHeaders = ["x-access-token":jwt]
            AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header) { $0.timeoutInterval = NetworkConstant.requestTimeiut }
                .validate()
                .responseDecodable(of: InfoDetailResponse.self) { response in
                    switch response.result {
                    case .success(let result):
                        completed(result.result)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
        }
    }
    
    func logout(completed: @escaping (_ result: Int) -> Void) {
        if let jwt = UserDefaults.standard.object(forKey: "jwt") as? String, let url = URL(string: URLString.logout) {
            let header: HTTPHeaders = ["x-access-token":jwt]
            AF.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: header) { $0.timeoutInterval = NetworkConstant.requestTimeiut }
                .validate()
                .responseDecodable(of: LogoutResponse.self) { response in
                    switch response.result {
                    case .success(let result):
                        completed(result.code)
                    case .failure(let error):
                        completed(5000)
                        print("logout Error: \(error.localizedDescription)")
                    }
                }
        }
    }
    
    func delete(completed: @escaping (_ result: Int) -> Void) {
        if let jwt = UserDefaults.standard.object(forKey: "jwt") as? String, let url = URL(string: URLString.delete) {
            let header: HTTPHeaders = ["x-access-token":jwt]
            AF.request(url, method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: header) { $0.timeoutInterval = NetworkConstant.requestTimeiut }
                .validate()
                .responseDecodable(of: DeleteResponse.self) { response in
                    switch response.result {
                    case .success(let result):
                        completed(result.code)
                    case .failure(let error):
                        completed(5000)
                        print("logout Error: \(error.localizedDescription)")
                    }
                }
        }
    }
}

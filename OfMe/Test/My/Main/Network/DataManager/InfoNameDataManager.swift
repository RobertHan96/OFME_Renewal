import Foundation
import Alamofire

class InfoNameDataManager{
    func getName(completed: @escaping (_ at: InfoName) -> Void) {
        if let url = URL(string: URLString.nickname), let jwt = UserDefaults.standard.object(forKey: "jwt") as? String {
            let header: HTTPHeaders = ["x-access-token":jwt]
            AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
                .validate()
                .responseDecodable(of: InfoResponse.self) { response in
                    switch response.result {
                    case .success(let result):
                        completed(result.result)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
        }
    }
}

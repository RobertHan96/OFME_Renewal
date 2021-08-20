import Foundation
import Alamofire

class MyInfoDataManager {
    func getInfo(completed: @escaping (_ at: MyInfoResponse) -> Void) {
        if let url = URL(string: URLString.mypage), let jwt = UserDefaults.standard.object(forKey: "jwt") as? String {
            let header: HTTPHeaders = ["x-access-token": jwt]
            AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
                .validate()
                .responseDecodable(of: MyInfoResponse.self) { response in
                    switch response.result {
                    case .success(let result):
                        completed(result)
                    case .failure(let error):
                        print("error: \(error.localizedDescription)")
                    }
                }
        }
    }
}

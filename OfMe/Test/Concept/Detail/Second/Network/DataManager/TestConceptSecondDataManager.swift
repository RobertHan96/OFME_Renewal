import UIKit
import Alamofire

class TestConceptSecondDataManager {
    func getTest(idx: Int, completed: @escaping (_ result: TestConceptSecond) -> Void) {
        if let url = URL(string: URLString.getConceptSecond+"/\(idx)"), let jwt = UserDefaults.standard.object(forKey: "jwt") as? String {
            let header: HTTPHeaders = ["x-access-token" : jwt]
            AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
                .validate()
                .responseDecodable(of: TestConceptSecondResponse.self) { response in
                    switch response.result {
                    case .success(let result):
                        completed(result.result[0])
                    case .failure(let error):
                        print("getTestError: \(error.localizedDescription)")
                    }
                }
        }
    }
}

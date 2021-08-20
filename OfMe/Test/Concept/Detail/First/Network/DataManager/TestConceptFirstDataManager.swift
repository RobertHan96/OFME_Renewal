import UIKit
import Alamofire

class TestConceptFirstDataManager {
    func getTest(completed: @escaping (_ result: [TestConceptFirst]) -> Void) {
        if let url = URL(string: URLString.getConceptFirst), let jwt = UserDefaults.standard.object(forKey: "jwt") as? String {
            let header: HTTPHeaders = ["x-access-token":jwt]
            AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
                .validate()
                .responseDecodable(of: TestConceptFirstResponse.self) { response in
                    switch response.result {
                    case .success(let result):
                        completed(result.result)
                    case .failure(let error):
                        print("getTestError: \(error.localizedDescription)")
                    }
                }
        }
    }
}

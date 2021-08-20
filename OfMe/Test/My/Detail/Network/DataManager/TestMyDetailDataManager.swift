import UIKit
import Alamofire

class TestMyDetailDataManager {
    func getQuestion(completed: @escaping (_ result: [TestMyDetail]) -> Void) {
        if let url = URL(string: URLString.getTest) {
            AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
                .validate()
                .responseDecodable(of: TestMyDetailResponse.self) { response in
                    switch response.result {
                    case .success(let result):
                        completed(result.result)
                    case .failure(let error):
                        print("getQuestion Error: \(error.localizedDescription)")
                    }
                }
        }
    }
}

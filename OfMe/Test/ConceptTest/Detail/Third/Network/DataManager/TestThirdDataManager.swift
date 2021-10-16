import UIKit
import Alamofire

class TestThirdDataManager {
    func getTest(completed: @escaping (_ result: TestDummy) -> Void) {
        if let url = URL(string: URLString.getConceptThird), let jwt = UserDefaults.standard.object(forKey: "jwt") as? String {
            let header: HTTPHeaders = ["x-access-token" : jwt]
            AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header) { $0.timeoutInterval = ApiCallConstant.requestTimeiut }
                .validate()
                .responseDecodable(of: TestConceptThirdResponse.self) { response in
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

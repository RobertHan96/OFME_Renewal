import UIKit
import Alamofire

class TestConceptFirstDataManager {
    let conceptLimitOver : Int = 3024
    let dailyTestLimitOver : Int = 3025
    
    func getFirstTest(completed: @escaping (_ result: [TestConceptFirst]) -> Void) {
        if let url = URL(string: URLString.getConceptFirst), let jwt = UserDefaults.standard.object(forKey: "jwt") as? String {
            let header: HTTPHeaders = ["x-access-token":jwt]
            AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header) { $0.timeoutInterval = ApiCallConstant.requestTimeiut }
                .validate()
                .responseDecodable(of: TestConceptFirstResponse.self) { response in
                    switch response.result {
                    case .success(let result):
                        if let data = result.result {
                            completed(data)
                        }
                    case .failure(let error):
                        print("getTestError: \(error.localizedDescription)")
                    }
                }
        }
    }

    func getisAvailableTester(completed: @escaping (_ result: Int) -> Void) {
        if let url = URL(string: URLString.getConceptFirst), let jwt = UserDefaults.standard.object(forKey: "jwt") as? String {
            let header: HTTPHeaders = ["x-access-token":jwt]
            AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header) { $0.timeoutInterval = ApiCallConstant.requestTimeiut }
                .validate()
                .responseDecodable(of: TestConceptFirstResponse.self) { response in
                    switch response.result {
                    case .success(let result):
                        completed(result.code)
                    case .failure(let error):
                        print("getTestError: \(error.localizedDescription)")
                    }
                }
        }
    }

}

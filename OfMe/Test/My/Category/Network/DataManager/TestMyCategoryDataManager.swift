import UIKit
import Alamofire

class TestMyCategoryDataManager {
    func getCategory(completed: @escaping (_ result: TestMyCategoryResponse) -> Void) {
        if let url = URL(string: URLString.cateogryType) {
            AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
                .validate()
                .responseDecodable(of: TestMyCategoryResponse.self) { response in
                    switch response.result {
                    case .success(let result):
                        completed(result)
                    case .failure(let error):
                        print("TestMyCategory error: \(error.localizedDescription)")
                    }
                }
        }
    }
}

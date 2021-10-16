import UIKit
import Alamofire

class FinishDataManager {
    func patchRate(ratingPoint: Int, completion: @escaping (_ resultCode: Int) -> Void) {
        if let url = URL(string: URLString.finishRate), let jwt = UserDefaults.standard.object(forKey: "jwt") as? String {
            let header: HTTPHeaders = ["x-access-token":jwt]
            let body: Parameters = [
                "conceptPoint":ratingPoint]
            print(body)
            AF.request(url, method: .patch, parameters: body, encoding: JSONEncoding.default, headers: header) { $0.timeoutInterval = ApiCallConstant.requestTimeiut }
                .validate()
                .responseDecodable(of: FinishRateResponse.self) { response in
                    switch response.result {
                    case .success(let result):
                        completion(result.code)
                    case .failure(let error):
                        print("rateError: \(error.localizedDescription)")
                    }
                }
        }
    }
    
    func patchFinish(completion: @escaping (_ : FinishEndResponse) -> Void) {
        if let url = URL(string: URLString.finishEnd), let jwt = UserDefaults.standard.object(forKey: "jwt") as? String {
            let header: HTTPHeaders = ["x-access-token":jwt]

            AF.request(url, method: .patch, parameters: nil, encoding: JSONEncoding.default, headers: header) { $0.timeoutInterval = ApiCallConstant.requestTimeiut }
                .validate()
                .responseDecodable(of: FinishEndResponse.self) { response in
                    switch response.result {
                    case .success(let result):
                        completion(result)
                    case .failure(let error):
                        print("patchFinish: \(error.localizedDescription)")
                    }
                }
        }
    }
}

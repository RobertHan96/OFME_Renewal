import UIKit
import Alamofire

class FinishDataManager {
    func patchRate(idx: Int, id: Int, completed: @escaping (_ at: Int) -> Void) {
        if let url = URL(string: URLString.finishRate), let jwt = UserDefaults.standard.object(forKey: "jwt") as? String {
            let header: HTTPHeaders = ["x-access-token":jwt]
            let body: Parameters = [
                "conceptId":id,
                "conceptPoint": idx,
            ]
            print(body)
            AF.request(url, method: .patch, parameters: body, encoding: JSONEncoding.default, headers: header)
                .validate()
                .responseDecodable(of: FinishRateResponse.self) { response in
                    switch response.result {
                    case .success(let result):
                        completed(result.code)
                    case .failure(let error):
                        print("rateError: \(error.localizedDescription)")
                    }
                }
        }
    }
    
    func patchFinish(time: Int, completed: @escaping (_ at: Int) -> Void) {
        if let url = URL(string: URLString.finishEnd), let jwt = UserDefaults.standard.object(forKey: "jwt") as? String {
            let header: HTTPHeaders = ["x-access-token":jwt]
            let body: Parameters = [
                "timer":time
            ]
            AF.request(url, method: .patch, parameters: body, encoding: JSONEncoding.default, headers: header)
                .validate()
                .responseDecodable(of: FinishEndResponse.self) { response in
                    switch response.result {
                    case .success(let result):
                        if result.result != nil  {
                            if result.result!.count > 0 {
                                completed(result.result!.first!.id)
                            }
                        }
                    case .failure(let error):
                        print("patchFinish: \(error.localizedDescription)")
                    }
                }
        }
    }
}

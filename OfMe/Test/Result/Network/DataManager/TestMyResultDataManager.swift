import UIKit
import Alamofire

class TestMyResultDataManager {
    func getResult(firstAnswer: Int, secondAnswer: Int,completed: @escaping (_ result: TestMyResult) -> Void) {
        if let url = URL(string: URLString.conceptResult+"/\(firstAnswer)/\(secondAnswer)/result"),
           let jwt = UserDefaults.standard.object(forKey: "jwt") as? String {
            
            let header: HTTPHeaders = ["x-access-token": jwt]
            AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
                .validate()
                .responseDecodable(of: TestMyResultResponse.self) { response in
                    switch response.result {
                    case .success(let result):
                        if let data = result.result {
                            completed(data)
                        }
                    case .failure(let error):
                        print("TestMyResult Error: \(error.localizedDescription)")
                }
            }
        }
    }

    func confrimTestResult(conceptId: Int,completed: @escaping (_ result: Int) -> Void) {
        if let url = URL(string: URLString.confirmCharacter+"/\(conceptId)"),
           let jwt = UserDefaults.standard.object(forKey: "jwt") as? String {
            
            let header: HTTPHeaders = ["x-access-token": jwt]
            AF.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: header)
                .validate()
                .responseDecodable(of: TestMyResultResponse.self) { response in
                    switch response.result {
                    case .success(let result):
                        print("LOGT",result)
                        completed(result.code)
                    case .failure(let error):
                        print("LOGT", response.result)
                        print("TestMyResult Error: \(error.localizedDescription)")
                    }
                }
        }
    }

}

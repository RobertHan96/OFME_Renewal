import UIKit
import Alamofire

class TestMyResultDataManager {
    func getResult(idx: Int, completed: @escaping (_ result: TestMyResult) -> Void) {
        if let url = URL(string: URLString.cateogryType+"/\(idx)/direct"), let jwt = UserDefaults.standard.object(forKey: "jwt") as? String {
            let header: HTTPHeaders = ["x-access-token": jwt]
            let parameter: Parameters = ["typeId": idx]
            AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header)
                .validate()
                .responseDecodable(of: TestMyResultResponse.self) { response in
                    switch response.result {
                    case .success(let result):
                        completed(result.result)
                    case .failure(let error):
                        print("TestMyResult Error: \(error.localizedDescription)")
                    }
                }
        }
    }
    
    func getResult(answer: [Int], answerSheet: [String], completed: @escaping (_ result: TestMyResult) -> Void) {
        var ans: [String:[String]] = [ "EI" : [], "NS":[],"TF":[],"PJ":[] ]
        for i in 0..<answer.count {
            if answer[i] == 0 {
                ans[answerSheet[i]]?.append("ENTP")
            } else {
                ans[answerSheet[i]]?.append("ISFJ")
            }
        }
        let parameter: Parameters = ans
        if let url = URL(string: URLString.getTest), let jwt = UserDefaults.standard.object(forKey: "jwt") as? String {
            let header: HTTPHeaders = ["x-access-token": jwt]
            AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header)
                .validate()
                .responseDecodable(of: TestMyResultResponse.self) { response in
                    switch response.result {
                    case .success(let result):
                        completed(result.result)
                    case .failure(let error):
                        print("TestMyResult Error: \(error.localizedDescription)")
                    }
                }
        }
    }
}

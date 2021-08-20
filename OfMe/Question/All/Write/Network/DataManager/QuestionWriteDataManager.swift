import Foundation
import Alamofire

class QuestionWriteDataManager {
    func getQuestion(idx: Int, completed: @escaping (_ at: [QuestionGet]) -> Void) {
        if let jwt = UserDefaults.standard.object(forKey: "jwt") as? String, let url = URL(string: "\(URLString.question)/\(idx)/answers") {
            let header: HTTPHeaders = ["x-access-token":jwt]
            AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
                .validate()
                .responseDecodable(of: QuestionGetResponse.self) { response in
                    switch response.result {
                    case .success(let result):
                        print(result)
                        completed(result.result)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
        }
    }
    
    func writeQuestion(idx: Int, text: String, isShare: Bool, method: HTTPMethod, completed: @escaping (_ at: Int) -> Void) {
        if let jwt = UserDefaults.standard.object(forKey: "jwt") as? String, let url = URL(string: "\(URLString.question)/answers") {
            let header: HTTPHeaders = ["x-access-token":jwt]
            let body: Parameters = [
                "questionId":idx,
                "answer":text,
                "share": isShare ? "Y" : "N",
            ]
            AF.request(url, method: method, parameters: body, encoding: JSONEncoding.default, headers: header)
                .validate()
                .responseDecodable(of: QuestionWrite.self) { response in
                    switch response.result {
                    case .success(let result):
                        print(result)
                        completed(result.code)
                    case .failure(let error):
                        print(error.localizedDescription)
                        completed(-1)
                    }
                }
        }
    }
    
    func delete(idx: Int, completed: @escaping (_ at: Int) -> Void) {
        if let jwt = UserDefaults.standard.object(forKey: "jwt") as? String, let url = URL(string: "\(URLString.question)/answers") {
            let header: HTTPHeaders = ["x-access-token":jwt]
            let body: Parameters = ["questionId":idx]
            AF.request(url, method: .delete, parameters: body, encoding: JSONEncoding.default, headers: header)
                .validate()
                .responseDecodable(of: QuestionWrite.self) { response in
                    switch response.result {
                    case .success(let result):
                        print(result)
                        completed(result.code)
                    case .failure(let error):
                        print(error.localizedDescription)
                        completed(-1)
                    }
                }
        }
    }
}

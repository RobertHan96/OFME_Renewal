import Foundation
import Alamofire

class SubAllDataManager {
    func getQuestion(completed: @escaping (_ result: [SubAllQuestion]) -> Void) {
        if let url = URL(string: URLString.question), let jwt = UserDefaults.standard.object(forKey: "jwt") as? String {
            let header: HTTPHeaders = ["x-access-token":jwt]
            AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
                .validate()
                .responseDecodable(of: SubAllQuestionResponse.self) { response in
                    switch response.result {
                    case .success(let result):
                        if let res = result.result {
                            completed(res)
                        }
                    case .failure(let error):
                        print("getQuestion: \(error.localizedDescription)")
                    }
                }
        }
    }
    
    func getReward(completed: @escaping (_ result: [QuestionReward]) -> Void) {
        if let url = URL(string: URLString.questionReward), let jwt = UserDefaults.standard.object(forKey: "jwt") as? String {
            let header: HTTPHeaders = ["x-access-token":jwt]
            AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
                .validate()
                .responseDecodable(of: QuestionRewardResponse.self) {response in
                    switch response.result {
                    case .success(let result):
                        completed(result.result)
                    case .failure(let error):
                        print("getQuestion: \(error.localizedDescription)")
                    }
                }
        }
    }
    
    func getQuestionView(url:String, completed: @escaping (_ result: [QuestionView]) -> Void) {
        if let url = URL(string: url), let jwt = UserDefaults.standard.object(forKey: "jwt") as? String {
            let header: HTTPHeaders = ["x-access-token":jwt]
            AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
                .validate()
                .responseDecodable(of: QuestionViewResponse.self) {response in
                    switch response.result {
                    case .success(let result):
                        print(result)
                        completed(result.result)
                    case .failure(let error):
                        print("getQuestion: \(error.localizedDescription)")
                    }
                }
        }
    }
    
    func getQuestionDetail(id: Int, completed: @escaping (_ result: QuestionDetailResponse)->Void) {
        if let url = URL(string: URLString.question+"/\(id)/pages"), let jwt = UserDefaults.standard.object(forKey: "jwt") as? String {
            let header: HTTPHeaders = ["x-access-token":jwt]
            AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
                .validate()
                .responseDecodable(of: QuestionDetailResponse.self) { response in
                    switch response.result {
                    case .success(let result):
                        print(result)
                        completed(result)
                    case .failure(let error):
                        print("getQuestion: \(error.localizedDescription)")
                        completed(QuestionDetailResponse(isSuccess: false, code: 0, message: "", result: nil))
                    }
                }
        }
    }
}

import Foundation
import Alamofire

class QuestionAllDataManager {
    func getQuestion(sort: String, answers: Int,completed: @escaping (_ result: [SubAllQuestion]) -> Void) {
        if let url = URL(string: URLString.questionList), let jwt = UserDefaults.standard.object(forKey: "jwt") as? String {
            let header: HTTPHeaders = ["x-access-token":jwt]
            let parm: Parameters = [
                "sort": sort,
                "answers": answers
            ]
            print(parm)
            AF.request(url, method: .get, parameters: parm, encoding: URLEncoding.queryString, headers: header) { $0.timeoutInterval = NetworkConstant.requestTimeiut }
                .validate()
                .responseDecodable(of: SubAllQuestionResponse.self) { response in
                    switch response.result {
                    case .success(let result):
                        if let res = result.result {
                            completed(res)
                        }
                    case .failure(let error):
                        print("error: \(error.localizedDescription)")
                    }
                }
        }
    }
}

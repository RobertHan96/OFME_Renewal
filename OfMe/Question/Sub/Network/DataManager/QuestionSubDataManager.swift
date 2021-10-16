import Foundation
import Alamofire

class QuestionSubDataManager {
    func declarations(idx: Int, completed: @escaping (_ at: Int) -> Void) {
        if let jwt = UserDefaults.standard.object(forKey: "jwt") as? String, let url = URL(string: "\(URLString.declarations)") {
            let header: HTTPHeaders = ["x-access-token":jwt]
            let body: Parameters = ["answerId":idx]
            AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header) { $0.timeoutInterval = ApiCallConstant.requestTimeiut }
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

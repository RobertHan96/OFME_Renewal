import UIKit
import Alamofire

class ConceptResultDataManager {
    
    func getConcept(completed: @escaping (_ result: [ConceptResult]) -> Void) {
        if let first = UserDefaults.standard.object(forKey: "stageOneResult") as? Int,
           let second = UserDefaults.standard.object(forKey: "stageTwoResult") as? Int {
            if let url = URL(string: URLString.conceptResult+"/\(first)/\(second)"), let jwt = UserDefaults.standard.object(forKey: "jwt") as? String {
                let header: HTTPHeaders = ["x-access-token":jwt]
                AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.queryString, headers: header)
                    .validate()
                    .responseDecodable(of: ConceptResultResponse.self) { response in
                        switch response.result {
                        case .success(let result):
                            print(result)
                            if result.result != nil {
                                completed(result.result!)
                            }
                        case .failure(let error):
                            print("register Error: \(error.localizedDescription)")
                        }
                    }
            }
        }
    }
    
    func registerConcept(completed: @escaping (_ at: Int) -> Void) {
        if let url = URL(string: URLString.conccept), let jwt = UserDefaults.standard.object(forKey: "jwt") as? String {
            let header: HTTPHeaders = ["x-access-token":jwt]
            var body: Parameters = [:]
            if let first = UserDefaults.standard.object(forKey: "stageOneResult") as? Int,
               let second = UserDefaults.standard.object(forKey: "stageTwoResult") as? Int {
                body = ["stageOneResult": first, "stageTwoResult": second]
                AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header)
                    .validate()
                    .responseDecodable(of: ConceptRegister.self) { response in
                        switch response.result {
                        case .success(let result):
                            if result.result != nil {
                                UserDefaults.standard.setValue(result.result!.conceptId, forKey: "conceptID")
                                completed(result.code)
                            }
                        case .failure(let error):
                            print("register Error: \(error.localizedDescription)")
                        }
                    }
            }
        }
    }
    
    func getConceptResult(completed: @escaping (_ result: [ConceptResult]) -> Void) {
        if let jwt = UserDefaults.standard.object(forKey: "jwt") as? String,
           let id = UserDefaults.standard.object(forKey: "conceptID") as? Int {
            let header: HTTPHeaders = ["x-access-token":jwt]
            if let url = URL(string: URLString.conccept+"/\(id)") {
                AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
                    .validate()
                    .responseDecodable(of: ConceptResultResponse.self) { response in
                        switch response.result {
                        case .success(let result):
                            print(result)
                            if let res = result.result {
                                completed(res)
                            } else {
                                completed([])
                            }
                        case .failure(let error):
                            completed([])
                            print("conceptResult Error: \(error.localizedDescription)")
                        }
                    }
            }
        }
    }
    
    func getConceptResult(idx: Int, completed: @escaping (_ result: [ConceptResult]) -> Void) {
        if let jwt = UserDefaults.standard.object(forKey: "jwt") as? String {
            let header: HTTPHeaders = ["x-access-token":jwt]
            if let url = URL(string: URLString.conccept+"/\(idx)") {
                print(url)
                AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
                    .validate()
                    .responseDecodable(of: ConceptResultResponse.self) { response in
                        switch response.result {
                        case .success(let result):
                            if let res = result.result {
                                completed(res)
                            } else {
                                completed([])
                            }
                        case .failure(let error):
                            completed([])
                            print("conceptResult Error: \(error.localizedDescription)")
                        }
                    }
            }
        }
    }
}

import Foundation
import Alamofire

class WriteDataManager {
    func getConcept(date: Date, completed: @escaping (_ result: [WriteConcept]) -> Void) {
        if let url = URL(string: URLString.date), let jwt = UserDefaults.standard.object(forKey: "jwt") as? String {
            let header: HTTPHeaders = ["x-access-token": jwt]
            let query: Parameters = [
                "months": date.month,
                "days": date.day,
                "years": date.year,
            ]
            print(query)
            AF.request(url, method: .get, parameters: query, encoding: URLEncoding.queryString, headers: header)
                .validate()
                .responseDecodable(of: WriteConceptResponse.self) { response in
                    switch response.result {
                    case .success(let result):
                        if let res = result.result {
                            completed(res)
                        }
                    case .failure(let error):
                        print("getConcept Error:\(error.localizedDescription)")
                    }
                }
        }
    }
    
    func sendWrite(info: WriteInfo, date: Date, completed: @escaping (_ result: Int) -> Void) {
        if let url = URL(string: URLString.diary), let jwt = UserDefaults.standard.object(forKey: "jwt") as? String{
            let header: HTTPHeaders = ["x-access-token": jwt]
            let parm: Parameters = [
                "title": info.title,
                "character": (info.idx == -1 ? -1 : info.idx),
                "text": info.content,
                "createAt": date.text,
                "img": []
            ]
            print(parm)
            AF.request(url, method: .post, parameters: parm, encoding: JSONEncoding.default, headers: header)
                .validate()
                .responseDecodable(of: WriteResponse.self) { response in
                    print(response.result)
                    switch response.result {
                    case .success(let result):
                        completed(result.code)
                    case .failure(let error):
                        completed(5000)
                        print(error.localizedDescription)
                    }
                }
        }
    }
    
    func patchWrite(info: WriteInfo, date: Date ,completed: @escaping (_ result: Int) -> Void) {
        if let url = URL(string: URLString.diary), let jwt = UserDefaults.standard.object(forKey: "jwt") as? String{
            let header: HTTPHeaders = ["x-access-token": jwt]
            let parm: Parameters = [
                "title": info.title,
                "character": (info.idx == -1 ? -1 : info.idx),
                "text": info.content,
                "createAt": date.text,
                "diaryId": info.diaryIdx,
                "img": []
            ]
            print(parm)
            AF.request(url, method: .patch, parameters: parm, encoding: JSONEncoding.default, headers: header)
                .validate()
                .responseDecodable(of: WriteResponse.self) { response in
                    print(response.result)
                    switch response.result {
                    case .success(let result):
                        completed(result.code)
                    case .failure(let error):
                        completed(5000)
                        print(error.localizedDescription)
                    }
                }
        }
    }
}

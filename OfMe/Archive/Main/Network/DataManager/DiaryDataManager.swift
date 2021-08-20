import UIKit
import Alamofire

class DiaryDataManager {
    func getDiary(date: Date, completed: @escaping (_ result: [DiaryGet]) -> Void) {
        if let url = URL(string: URLString.diary), let jwt = UserDefaults.standard.object(forKey: "jwt") as? String {
            let header: HTTPHeaders = ["x-access-token":jwt]
            let query: Parameters = [
                "months":date.month,
                "days":date.day,
                "years":date.year
            ]
            AF.request(url, method: .get, parameters: query, encoding: URLEncoding.queryString, headers: header)
                .validate()
                .responseDecodable(of: DiaryGetResponse.self) { response in
                    switch response.result {
                    case .success(let result):
                        print(result)
                        if result.result == nil {
                            completed([])
                        } else {
                            completed(result.result!)
                        }
                    case .failure(let error):
                        completed([])
                        print("getDiary Error: \(error.localizedDescription)")
                    }
                }
        }
    }
    
    func deleteDiary(idx: Int, completed: @escaping (_ result: Int)->Void) {
        if let url = URL(string: URLString.diary), let jwt = UserDefaults.standard.object(forKey: "jwt") as? String {
            let header: HTTPHeaders = ["x-access-token":jwt]
            let query: Parameters = ["diaryId":idx]
            print(url)
            AF.request(url, method: .delete, parameters: query, encoding: JSONEncoding.default, headers: header)
                .validate()
                .responseDecodable(of: DeleteDiary.self) { response in
                    print(response.result)
                    switch response.result {
                    case .success(let result):
                        print(result)
                        completed(result.code)
                    case .failure(let error):
                        completed(5000)
                        print("delete Error:\(error.localizedDescription)")
                    }
                }
        }
    }
}

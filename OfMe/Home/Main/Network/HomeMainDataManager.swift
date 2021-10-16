import UIKit
import Alamofire

class HomeMainDataManager {
    func getMainHomeData(completed: @escaping (_ result: HomeMainResult) -> Void) {
        if let url = URL(string: NewURLString.homeMain + Action.ActionName.defaultUrl.url), let jwt = UserDefaults.standard.object(forKey: "jwt") as? String {
            let header: HTTPHeaders = ["x-access-token" : jwt]
            
            AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header) { $0.timeoutInterval = NetworkConstant.requestTimeiut }
                .validate()
                .responseDecodable(of: HomeMainResponse.self) { response in
                    switch response.result {
                    case .success(let result):
                        if let result = result.result {
                            completed(result)
                        }
                    case .failure(let error):
                        print("get HomeMainData Error: \(error.localizedDescription)")
                    }
                }
        }
    }
    
    func getMainHomeData(actionIndex:Int, completed: @escaping (_ result: HomeMainResult) -> Void) {
        if let url = URL(string: NewURLString.homeMain + "/\(Action().getActionNameFromIndexPath(indexPath: actionIndex))"), let jwt = UserDefaults.standard.object(forKey: "jwt") as? String {
            let header: HTTPHeaders = ["x-access-token" : jwt]
            
            AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header) { $0.timeoutInterval = NetworkConstant.requestTimeiut }
                .validate()
                .responseDecodable(of: HomeMainResponse.self) { response in
                    switch response.result {
                    case .success(let result):
                        if let result = result.result {
                            completed(result)
                        }
                    case .failure(let error):
                        print("LOGT", response.data)
                        print("get HomeMainData Error: \(error.localizedDescription)")
                    }
                }
        }
    }

    
}

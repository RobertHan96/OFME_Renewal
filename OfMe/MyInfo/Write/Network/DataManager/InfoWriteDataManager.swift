import Foundation
import Alamofire

class InfoWriteDataManager {
    func changeName(text:String, completed: @escaping (_ res: Int) -> Void) {
        if let url = URL(string: URLString.infoDetail), let jwt = UserDefaults.standard.object(forKey: "jwt") as? String {
            let header: HTTPHeaders = ["x-access-token":jwt]
            let parameter: Parameters = ["nickname":text, "imgUrl": "https://ofmebucket.s3.ap-northeast-2.amazonaws.com/profileImage.png"]
            AF.request(url, method: .patch, parameters: parameter, encoding: JSONEncoding.default, headers: header) { $0.timeoutInterval = NetworkConstant.requestTimeiut }
                .validate()
                .responseDecodable(of: InfoWriteResponse.self) { response in
                    switch response.result {
                    case .success(let result):
                        completed(result.code)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
        }
    }
    
    func changePassword(origin: String ,new: String, new2: String, completed: @escaping (_ res: Int) -> Void) {
        if let url = URL(string: URLString.passwordChange), let jwt = UserDefaults.standard.object(forKey: "jwt") as? String {
            let header: HTTPHeaders = ["x-access-token":jwt]
            let parameter: Parameters = ["newPassword":new,
                                         "checkPassword":new2,
                                         "password":origin
            ]
            AF.request(url, method: .patch, parameters: parameter, encoding: JSONEncoding.default, headers: header) { $0.timeoutInterval = NetworkConstant.requestTimeiut }
                .validate()
                .responseDecodable(of: InfoWriteResponse.self) { response in
                    switch response.result {
                    case .success(let result):
                        completed(result.code)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
        }
    }
}

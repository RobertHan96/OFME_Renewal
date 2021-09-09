import UIKit
import Alamofire

class NicknameDataManager {
    
    private enum param: String {
        case nickname = "nickname"
    }
    
    func postCheckUserNicknameDuplecated(nickname: String, completion: @escaping (NicknameResponse) -> Void) {
        if let url = URL(string: URLString.duplecatedNickname+"/\(nickname)") {
            AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
                .validate()
                .responseDecodable(of: NicknameResponse.self) { response in
                    switch response.result {
                    case .success(let result):
                        print("LOG: 닉네임 중복 검사 결과", result)
                        completion(result)
                    case .failure(let error):
                        print("LOG: 닉네임 중복 검사 실패 Error: \(error.errorDescription ?? "error")", response )
                }
            }
        }
    }
    
    func postUserNickname(nickname: String, completion: @escaping (NicknameResponse) -> Void) {
        let parameter: Parameters = [param.nickname.rawValue:nickname]
        if let url = URL(string: URLString.makeNickname) {
            AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: nil)
                .validate()
                .responseDecodable(of: NicknameResponse.self) { response in
                    switch response.result {
                    case .success(let result):
                        print("LOG: 닉네임 생성 성공", result)
                        completion(result)
                    case .failure(let error):
                        print("LOG: 닉네임 생성 실패 \(error.errorDescription ?? "error")", response )
                }
            }
        }
    }
}

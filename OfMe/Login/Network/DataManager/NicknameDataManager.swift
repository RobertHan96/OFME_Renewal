import UIKit
import Alamofire

class NicknameDataManager {
    
    private enum Params: String {
        case nickname = "nickname"
    }

    enum Errors: Int, Error {
        case emptyName = 2006
        case overSizeName = 2007
        case notKoreanName = 2020
        case duplecatedName = 3002
    }
    
    func postCheckUserNicknameDuplecated(nickname: String, completion: @escaping (Result<NicknameResponse, Errors>) -> Void) {
        let strUrl = URLString.duplecatedNickname+"/\(nickname)"
        let encodedUrl = strUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

        if let url = URL(string: encodedUrl ?? URLString.duplecatedNickname){
            AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil) { $0.timeoutInterval = NetworkConstant.requestTimeiut }
                .validate()
                .responseDecodable(of: NicknameResponse.self) { response in
                    print("LOG: 닉네임 중복 검사 결과", response.result)
                    switch response.result {
                    case .success(let result):
                        switch result.code {
                        case 1000:
                            completion(.success(result))
                        case Errors.notKoreanName.rawValue:
                            completion(.failure(.notKoreanName))
                        case Errors.duplecatedName.rawValue:
                            completion(.failure(.duplecatedName))
                        default:
                            completion(.failure(.overSizeName))
                        }
                    case .failure(let error):
                        print("LOG: 닉네임 중복 검사 실패 Error: \(error.errorDescription ?? "error")", response )
                }
            }
        }
    }
    
    func postUserNickname(nickname: String, completion: @escaping (NicknameResponse) -> Void) {
        let parameter: Parameters = [Params.nickname.rawValue:nickname]
        if let url = URL(string: URLString.makeNickname) {
            let header: HTTPHeaders = ["x-access-token": Device().getTokenInfo()]
            AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header) { $0.timeoutInterval = NetworkConstant.requestTimeiut }
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

struct NicknameResponse: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
}

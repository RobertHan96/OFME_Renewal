import UIKit
import Alamofire

class HomeMainDataManager {
    func getCharacter(completed: @escaping (_ result: [CharacterResult]) -> Void) {
        if let url = URL(string: URLString.character), let jwt = UserDefaults.standard.object(forKey: "jwt") as? String {
            let header: HTTPHeaders = ["x-access-token" : jwt]
            AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
                .validate()
                .responseDecodable(of: CharacterResponse.self) { response in
                    switch response.result {
                    case .success(let result):
                        if let result = result.result {
                            completed(result)
                        } else {
                            completed(CharacterResponse.error)
                        }
                    case .failure(let error):
                        completed(CharacterResponse.error)
                        print("getCharacter Error: \(error.localizedDescription)")
                    }
                }
        }
    }
    
    func getCharacterAction(completed: @escaping (_ result: [CharacterAction]) -> Void) {
        if let url = URL(string: URLString.characterAction), let jwt = UserDefaults.standard.object(forKey: "jwt") as? String {
            let header: HTTPHeaders = ["x-access-token" : jwt]
            AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
                .validate()
                .responseDecodable(of: CharacterActionResponse.self) { response in
                    switch response.result {
                    case .success(let result):
                        if let res = result.result {
                            completed(res)
                        } else {
                            completed(CharacterActionResponse.error)
                        }
                    case .failure(let error):
                        completed(CharacterActionResponse.error)
                        print("getCharacterAction Error: \(error.localizedDescription)")
                    }
                }
        }
    }
    
    func patchCharacterTime(time: Int) {
        if let url = URL(string: URLString.characterTime), let jwt = UserDefaults.standard.object(forKey: "jwt") as? String {
            let header: HTTPHeaders = ["x-access-token" : jwt]
            let body: Parameters = ["timer":time]
            UserDefaults.standard.removeObject(forKey: "time")
            AF.request(url, method: .patch, parameters: body, encoding: JSONEncoding.default, headers: header)
                .validate()
                .responseDecodable(of: CharacterTimeResponse.self) { response in
                    switch response.result {
                    case .success(let result):
                        print(result.message)
                    case .failure(let error):
                        print("patchTime Error: \(error.localizedDescription)")
                    }
                }
        }
    }
}

import Foundation

struct AutoLoginResponse: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: AutoLogin?
    
    static let error: AutoLoginResponse = AutoLoginResponse(isSuccess: false, code: -1, message: "", result: nil)
}

struct AutoLogin: Codable {
    var userId: Int
    var jwt: String
}

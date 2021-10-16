import Foundation


struct LoginResponse: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: UserInfo?
    
    static let error: LoginResponse = LoginResponse(isSuccess: false, code: 5000, message: "", result: UserInfo(userId: -1, jwt: ""))
}

struct UserInfo: Codable {
    var userId: Int
    var jwt: String
}

struct SocialLoginResponse: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: SocialLoginUserInfo?
    
    static let error: SocialLoginResponse = SocialLoginResponse(isSuccess: false, code: 5000, message: "", result: SocialLoginUserInfo(Id: -1, jwt: ""))
}

struct SocialLoginUserInfo: Codable {
    var Id: Int?
    var jwt: String?
}

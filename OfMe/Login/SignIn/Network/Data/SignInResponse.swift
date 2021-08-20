import Foundation

struct SignInResponse: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: UserIdx?
    
    
    static let error: SignInResponse = SignInResponse(isSuccess: false, code: 5000, message: "", result: UserIdx(createUser: 0))
}

struct UserIdx: Codable {
    var createUser: Int
}

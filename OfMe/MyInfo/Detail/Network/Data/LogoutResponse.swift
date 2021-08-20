import Foundation

struct LogoutResponse: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: Logout?
}

struct Logout: Codable {
    var userId: Int
}


struct InfoDetailResponse: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [InfoDetail]
}

struct InfoDetail: Codable {
    var imgUrl: String
    var email: String
    var nickname: String
}

struct DeleteResponse: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: Delete
}

struct Delete: Codable {
    var userId: Int
}

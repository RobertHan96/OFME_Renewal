import Foundation


struct InfoResponse: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: InfoName
}

struct InfoName: Codable {
    var id: Int
    var nickname: String
}

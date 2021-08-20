import Foundation

struct InfoWriteResponse: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
}

import Foundation

struct FinishEndResponse: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [FinishEnd]?
}

struct FinishEnd: Codable {
    var id: Int
}

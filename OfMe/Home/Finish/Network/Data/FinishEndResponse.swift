import Foundation

struct FinishEndResponse: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: FinishEnd?
}

struct FinishEnd: Codable {
    var clientTime: Int
    var url: String
    var conceptId: Int
}

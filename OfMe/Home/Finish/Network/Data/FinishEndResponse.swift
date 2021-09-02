import Foundation

struct FinishEndResponse: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: FinishEnd?
}

struct FinishEnd: Codable {
    var timer: Int
    var url: String
    var conceptId: Int
}

import Foundation

struct QuestionGetResponse: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [QuestionGet]
}

struct QuestionGet: Codable {
    var question: String
    var answer: String
    var share: String
    var createAt: String
}

struct QuestionWrite: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
}

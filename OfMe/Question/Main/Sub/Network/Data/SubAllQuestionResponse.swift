import Foundation

struct SubAllQuestionResponse: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [SubAllQuestion]?
}

struct SubAllQuestion: Codable {
    var id: Int
    var sort: String
    var question: String
    var share: String?
}

struct QuestionRewardResponse: Codable{
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [QuestionReward]
}

struct QuestionReward: Codable {
    var countQnA: Int
    var sumPoint: String
}


struct QuestionViewResponse: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [QuestionView]
}

struct QuestionView: Codable {
    var questionId: Int
    var question: String
    var aroundId: Int?
}

struct QuestionDetailResponse: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [QuestionDetail]?
}

struct QuestionDetail: Codable {
    var question: String
    var imgUrl: String?
    var nickname: String
    var userId: Int
    var answer: String
    var answerId: Int
    var createAt: String
}

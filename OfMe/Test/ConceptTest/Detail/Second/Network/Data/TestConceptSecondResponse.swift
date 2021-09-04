import Foundation

struct TestConceptSecondResponse: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [TestConceptSecond]
}

struct TestConceptSecond: Codable {
    var id: Int
    var keywordId: Int
    var question: String
    var highlight: String
    var answer1: String
    var answer2: String
    var answer3: String
    var answer4: String
}

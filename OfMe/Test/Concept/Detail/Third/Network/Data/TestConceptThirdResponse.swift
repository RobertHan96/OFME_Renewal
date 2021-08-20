import Foundation

struct TestConceptThirdResponse: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [TestDummy]
}

struct TestDummy: Codable {
    var id: Int
    var question: String
    var highlight: String
    var answer1: String
    var answer2: String
    var answer3: String
    var answer4: String
}

import Foundation

struct TestMyCategoryResponse: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [TestMyCategory]
}

struct TestMyCategory: Codable {
    var id: Int
    var name: String
    var highlight: String
}


import Foundation

struct TestMyResultResponse: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: TestMyResult
}

struct TestMyResult: Codable {
    var typeId: Int
    var subName: String
    var name: String
    var highlight: String
    var keyword: String
    var description1: String
    var description2: String
}

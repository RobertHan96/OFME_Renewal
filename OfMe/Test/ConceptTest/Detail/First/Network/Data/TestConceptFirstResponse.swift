import Foundation

struct TestConceptFirstResponse: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [TestConceptFirst]?
}

struct TestConceptFirst: Codable {
    var id: Int
    var keyword: String
}

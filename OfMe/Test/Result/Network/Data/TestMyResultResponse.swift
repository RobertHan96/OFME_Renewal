import Foundation

struct TestMyResultResponse: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: TestMyResult?
}

struct TestMyResult: Codable {
    var id: Int
    var url: String
    var name: String
    var subName: String
    var description: String
    var advantage: String
    var habit: String
    var behavior: String
    var value: String
    var music: String
    var url2: String
}

struct ConfirmTestResultResponse: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: ConceptId?
}

struct ConceptId: Codable {
    var conceptId: String
}

import Foundation

struct ConceptRegister: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: ConceptIDResult?
}

struct ConceptIDResult: Codable {
    var conceptId: Int
}

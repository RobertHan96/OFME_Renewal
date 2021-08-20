import Foundation

struct WriteConceptResponse: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [WriteConcept]?
}

struct WriteConcept: Codable {
    var conceptId: Int
    var name: String
}


struct WriteResponse: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
}

import Foundation

struct ConceptResultResponse: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [ConceptResult]?
    
    static let error = ConceptResultResponse(isSuccess: false, code: 5000, message: "", result: [])
}

struct ConceptResult: Codable {
    var id: Int
    var name: String
    var url: String
    var subName: String
    var description: String
    var advantage: String
    var habit: String
    var behavior: String
    var value: String
    var music: String
}

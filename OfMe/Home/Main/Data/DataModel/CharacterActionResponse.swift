import Foundation

struct CharacterActionResponse: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [CharacterAction]?
    
    static let error: [CharacterAction] = []
}

struct CharacterAction: Codable {
    var id: Int
    var situation: String
    var url: String
}

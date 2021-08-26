import Foundation

struct CharacterResponse: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [CharacterResult]?
    
    static let error: [CharacterResult] = []
}

struct CharacterResult: Codable {
    var nickname: String
    var name: String?
    var id: Int?
    var url: String?
    var timer: Int?
}

struct EmptyConcept: Codable {
    var conceptProgressCheck: String
    var nickname: String
}

struct UserConcept: Codable {
    var conceptProgressCheck: String
    var image: [String]
    var data: CharacterFeatures
}

struct CharacterFeatures: Codable {
    var id: Int
    var name: String
    var advantage: String
    var habit: String
    var behavior: String
    var value: String
    var music: String
}

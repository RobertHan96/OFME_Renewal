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

import Foundation

struct HomeMainResponse: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: HomeMainResult?
}

struct HomeMainResult: Codable {
    var conceptProgressCheck: String
    var nickname: String?
    var image: [String]?
    var data: CharacterFeatures?
}

struct CharacterFeatures: Codable {
    var id: Int?
    var name: String?
    var advantage: String?
    var habit: String?
    var behavior: String?
    var value: String?
    var music: String?
    var isFirstMain: String?
}

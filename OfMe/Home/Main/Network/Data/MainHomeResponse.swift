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

struct CharacterFeatureCellModel {
    static let totalCharacterFeature: Int = 5
    static let characterFeatures: [String] = [
        CharacterFeatureParsingName.advantage.rawValue,
        CharacterFeatureParsingName.habit.rawValue,
        CharacterFeatureParsingName.behavior.rawValue,
        CharacterFeatureParsingName.value.rawValue,
        CharacterFeatureParsingName.music.rawValue,
    ]
}


enum CharacterFeatureParsingName: String {
    case advantage = "advantage"
    case habit = "habit"
    case behavior = "behavior"
    case value = "value"
    case music = "music"
}

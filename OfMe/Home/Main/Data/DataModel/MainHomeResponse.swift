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
    var clientTime: Int?
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
    
    subscript(key: String) -> String? {
        get {
            if key == "advantage" {
                return advantage
            } else if key == "habit" {
                return habit
            }  else if key == "behavior" {
                return behavior
            } else if key == "value" {
                return value
            } else if key == "music" {
                return music
            }
            
            return nil
        }
        set {
            if key == "advantage" {
                advantage = newValue
            } else if key == "habit" {
                habit = newValue
            } else if key == "behavior" {
                 behavior = newValue
            } else if key == "value" {
                value = newValue
            } else if key == "music" {
                music = newValue
            }
        }
    }
}

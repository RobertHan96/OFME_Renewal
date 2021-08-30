//
//  Concpet.swift
//  OfMe
//
//  Created by HanaHan on 2021/08/30.
//

// 메인 화면 : 캐릭터, 컨셉 정보 표시에 필요한 구조체 정리
import Foundation

struct FavoriteSong {
    var name: String
    var artist: String
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


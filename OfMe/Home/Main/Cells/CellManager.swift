//
//  CellManager.swift
//  OfMe
//
//  Created by HanaHan on 2021/08/25.
//

import Foundation
import UIKit

struct CellManager {
    static let TimeInfoCellName = "TimeInfoCell" // 최상단 캐릭터 진행시간 정보
    static let CharacterCellName = "CharacterCell" // 액션에 따른 캐릭터 이미지 표시
    static let CharacterInfoCellName = "CharacterInfoCell" // 캐릭터 정보를 표시할 cell, TableView & Page Controll Embeded
    static let CharacterFeatureCellName = "CharacterFeatureTableViewCell" // TableView안에서 좌/우 스와이프를 통해 캐릭터 특성 표시
    static let ConceptSugesstionCellName = "ConceptSugesstionCell" // 진행 중인 컨셉이 없는 유저에게 CharacterFeatureTableViewCell 대신 정보 제공
    
    static let TimeInfoCellIdentifier = "timeInfo"
    static let CharacterCellIdentifier = "character"
    static let CharacterInfoCellIdentifier = "characterInfo"
    static let CharacterFeatureCellIdentifier = "characterFeature"
    static let ConceptSugesstionCellIdentifier = "conceptSugesstion"
    
}

extension HomeMainViewController {
    // 캐릭터 존재 유/무에 따라서 메인 화면 최하단에 보여줄 cell 반환
    func getBottomCell(isEmptyCharacter: Bool, userConcept: UserConcept?, completion: @escaping(UITableViewCell) -> Void ) -> UITableViewCell {
        switch isEmptyCharacter {
        case false: // 캐릭터가 비어있지 않다면 -> 캐릭터 정보 cell 표시
            guard let characterInfoCell = homeMainTableView.dequeueReusableCell(withIdentifier: CellManager.CharacterInfoCellIdentifier) as? CharacterInfoCell else { return UITableViewCell() }
            characterInfoCell.configure(userConcept: userConcept)
            return characterInfoCell
        default: // 캐릭터가 비어있다면 -> 컨셉 추천 cell 표시
            guard let conceptSugesstionCell = homeMainTableView.dequeueReusableCell(withIdentifier: CellManager.ConceptSugesstionCellIdentifier) as? CharacterInfoCell else { return UITableViewCell() }
            return conceptSugesstionCell
        }
    }

}

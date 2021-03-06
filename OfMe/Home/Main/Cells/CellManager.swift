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
//    static let CharacterFeatureCellName = "CharacterFeatureTableViewCell" // TableView안에서 좌/우 스와이프를 통해 캐릭터 특성 표시
    static let ConceptSugesstionCellName = "ConceptSugesstionCell" // 진행 중인 컨셉이 없는 유저에게 CharacterFeatureTableViewCell 대신 정보 제공
    static let CharacterFeatureCellName = "CharacterFeatureCell"
    static let CharacterFavoriteMusicCellIName = "CharacterFavoriteMusicCell" // 컨셉별 추천곡 cell
    static let ActionButtonCellName = "ActionButtonCell" // 사이드 메뉴내 각 버튼 액션 cell

    
    static let TimeInfoCellIdentifier = "timeInfo"
    static let CharacterCellIdentifier = "character"
    static let CharacterInfoCellIdentifier = "characterInfo"
    static let CharacterFeatureCellIdentifier = "characterFeature"
    static let ConceptSugesstionCellIdentifier = "conceptSugesstion"
    static let CharacterFavoriteMusicCellIdentifier = "characterFavoriteMusic"
    static let ActionButtonCellIdentifier = "actionButtonCell"
    
    // Finish 관련 cell
    static let StarRatingCellName = "StarRatingCell" // 별점 평가 cell
    static let StarRatingCellIdentifier = "starRatingCell"
    static let StepCellName = "StepCell" // STEP1, 2, 안내문구 cell
    static let StepCellIdentifier = "stepCell"
    static let ConceptResultSummaryCellName = "ConceptResultSummaryCell" // 최상단 컨셉 결과 요약 cell
    static let ConceptResultSummaryCellIdentifier = "conceptResultSummaryCell"
    static let FinishButtonCellName = "FinishButtonCell" // 최하단 컨셉 종료, 나중에하기 버튼 cell
    static let FinishButtonCellIdentifier = "finishButtonCell"
    static let CharacterSummaryCellName = "CharacterSummaryCell" // 컨셉 테스트 결과 화면 상단에 표시되는 캐릭터 정보 요약 cell
    static let CharacterSummaryCellIdentifier = "characterSummaryCell"
}

extension HomeMainViewController {
    func getBottomCellWithEmptyConcept() -> ConceptSugesstionCell{
        let conceptSugesstionCell = homeMainTableView.dequeueReusableCell(withIdentifier: CellManager.ConceptSugesstionCellIdentifier) as! ConceptSugesstionCell
        conceptSugesstionCell.delegate = self
        
        return conceptSugesstionCell
    }

    func getBottomCellWithConcept(userConcept: HomeMainResult?) -> CharacterInfoCell{
        let characterInfoCell = homeMainTableView.dequeueReusableCell(withIdentifier: CellManager.CharacterInfoCellIdentifier) as! CharacterInfoCell
        characterInfoCell.configure(userConcept: userConcept)
        return characterInfoCell
    }

}

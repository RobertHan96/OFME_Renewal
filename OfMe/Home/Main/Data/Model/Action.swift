//
//  Action.swift
//  OfMe
//
//  Created by HanaHan on 2021/09/01.
//

import Foundation

struct Action {
    
    var name: String = ""
    static let defaultActionIndexPath: Int = 6

    
    static let actions: [String] = [ActionName.water.rawValue,
                                    ActionName.sun.rawValue,
                                    ActionName.handTree.rawValue,
                                    ActionName.sleep.rawValue,
                                    ActionName.tv.rawValue,
                                    ActionName._default.rawValue ]

    func getActionNameFromIndexPath(indexPath: Int) -> String {
        switch indexPath {
        case 0:
            return ActionName.water.rawValue
        case 1:
            return ActionName.sun.rawValue
        case 2:
            return ActionName._handTree.rawValue
        case 3:
            return ActionName.sleep.rawValue
        case 4:
            return ActionName.tv.rawValue
        default:
            return ActionName.defaultUrl.rawValue
        }
    }
    
    func getNameForLabel() -> String {
        switch self.name {
            case "water" :
                    return "물마시기"
            case "sleep" :
                    return "낮잠자기"
            case "sun" :
                    return "햇빛보기"
            case "tv" :
                    return "티비보기"
            case "handTree" :
                    return "물구나무"
            case "_default" :
                    return "돌아가기"
            default:
                return "돌아가기"
        }
    }
    
    
    enum ActionName: String {
        case water = "water"
        case sleep = "sleep"
        case sun = "sun"
        case tv = "tv"
        case handTree = "handTree"
        case _handTree = "reverse" // 서버에 저장된 이미지 이름과, 클라에서 저장 중인게 달라서 _로 구분
        case _default = "reset" // 서버에 저장된 이미지 이름과, 클라에서 저장 중인게 달라서 _로 구분
        case defaultUrl = "default"
        
        var url: String {
            return "/\(self)"
        }
    }
}

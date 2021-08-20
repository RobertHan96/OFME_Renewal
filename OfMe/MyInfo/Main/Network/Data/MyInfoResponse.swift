import Foundation

struct MyInfoResponse: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var selectMypageResult: [MyInfo]
    var selectMyfriendResult: [MyFriend]
    var selectMyhistoryResult: [MyHistory]
}

struct MyInfo: Codable {
    var nickname:String
    var name:String?
    var imgUrl:String
    var highlight:String?
    var point:String
}

struct MyFriend: Codable {
    var url: String
    var name: String
    var conceptPoint: Int
    var conceptId: Int
}

struct MyHistory: Codable {
    var highlight: String
    var createAt: String
}


import Foundation

struct DiaryGetResponse: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [DiaryGet]?
    
    static let error: [DiaryGet] = []
}

struct DiaryGet: Codable {
    var id: Int
    var userId: Int
    var conceptId: Int
    var name: String?
    var title: String
    var content: String
    var createAt: String
}

struct DeleteDiary: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
}

import Foundation

struct TestMyDetailResponse: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [TestMyDetail]
    
}

struct TestMyDetail: Codable {
    var id: Int
    var sort: String
    var question: String
    var highlight: String
    var ENTPanswer: String
    var ISFJanswer: String
}

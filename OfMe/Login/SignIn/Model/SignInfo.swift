import Foundation


class SignInfo {
    var email: String
    var password2: String
    var password: String
    var nickName: String
    var check: Bool
    var passwordCheck: Bool
    
    init() {
        email = ""
        password = ""
        nickName = ""
        password2 = password
        check = false
        passwordCheck = true
    }
}

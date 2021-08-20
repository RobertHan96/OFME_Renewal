import Foundation

typealias Info = SignInfo
typealias result = SignInResponse
protocol SignInProtocol {
    func postSignRequest(vc: SignInViewController,
                         info: Info,
                         completion: @escaping (_ result: result) -> Void)
}

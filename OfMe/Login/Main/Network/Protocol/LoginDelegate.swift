import Foundation

typealias viewController = LoginMainViewController
typealias response = LoginResponse
protocol LoginDelegate {
    func postLogin(vc: viewController,
                   email: String,
                   password: String,
                   completion: @escaping (_ result: response) -> Void)
}

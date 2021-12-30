import UIKit
import IQKeyboardManager
import Firebase
import FirebaseAnalytics
import KakaoSDKCommon

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Thread.sleep(forTimeInterval: 2)        
        IQKeyboardManager.shared().isEnabled = true
        FirebaseApp.configure()
        Analytics.logEvent("init", parameters: nil)
        KakaoSDKCommon.initSDK(appKey: KobisKey.KAKAO_APP_KEY)
        
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }


}


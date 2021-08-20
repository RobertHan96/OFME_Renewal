//
//  SceneDelegate.swift
//  OfMe
//
//  Created by 김태훈 on 2021/06/28.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    let dataManager: AutoLoginDataManager = AutoLoginDataManager()


    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
    
        self.window = UIWindow(windowScene: scene as! UIWindowScene)
        dataManager.autoLogin { result in
            if result.code == 1000 {
                UserDefaults.standard.setValue(result.result?.jwt, forKey: "jwt")
                UserDefaults.standard.setValue(result.result?.userId, forKey: "userID")
                let mainVC = CustomTabBarViewController()
                self.window?.rootViewController = mainVC
            } else {
                let mainVC = LoginMainViewController()
                let navigationController = UINavigationController(rootViewController: mainVC)
                self.window?.rootViewController = navigationController
            }
            self.window?.makeKeyAndVisible()
        }
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        if let time = UserDefaults.standard.object(forKey: "time") as? Int {
            HomeMainDataManager().patchCharacterTime(time: time)
        }
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        if let time = UserDefaults.standard.object(forKey: "time") as? Int {
            HomeMainDataManager().patchCharacterTime(time: time)
        }
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}


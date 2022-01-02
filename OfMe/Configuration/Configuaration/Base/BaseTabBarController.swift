import UIKit

struct BaseTabBarController {
    func initMainTabBar() -> UITabBarController {
        let tabBarController = UITabBarController()
        let homeVC = HomeMainViewController()
        let questionVC = QuestionViewController()
        let testVC = TestConceptMainViewController()
//        let myinfoVC = MyInfoMainViewController()
        let myinfoVC = NewMainMyInfoViewController()
        let homeTabBarItem = UITabBarItem(title: nil, image: UIImage(named: ImgName.imgName(of: .homeIcon)), tag: 0)
        let testTabBarItem = UITabBarItem(title: nil, image: UIImage(named:ImgName.imgName(of: .testIcon)), tag: 1)
        let questionTabBarItem = UITabBarItem(title: nil, image: UIImage(named: ImgName.imgName(of: .questionIcon)), tag: 2)
        let myinfoTabBarItem = UITabBarItem(title: nil, image: UIImage(named: ImgName.imgName(of: .defaultProfile)), tag: 3)

        let homeNavVC = UINavigationController(rootViewController: homeVC)
        let questionNavVC = UINavigationController(rootViewController: questionVC)
        let testNavVC = UINavigationController(rootViewController: testVC)
        let myinfoNavVC = UINavigationController(rootViewController: myinfoVC)

        homeNavVC.tabBarItem = homeTabBarItem
        questionNavVC.tabBarItem = questionTabBarItem
        testNavVC.tabBarItem = testTabBarItem
        myinfoNavVC.tabBarItem = myinfoTabBarItem
        
        tabBarController.tabBar.unselectedItemTintColor = .tabBarIconColor
        tabBarController.tabBar.tintColor = .selectedTabBarIconColor
        tabBarController.tabBar.shadowImage = UIImage()
        tabBarController.tabBar.backgroundImage = UIImage()
        tabBarController.tabBar.clipsToBounds = true
        tabBarController.viewControllers = [
            homeNavVC,
            testNavVC,
            questionNavVC,
            myinfoNavVC
        ]
        
        return tabBarController
    }
}

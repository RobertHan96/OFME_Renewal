import UIKit

class CustomTabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    let homeVC = HomeMainViewController()
    let questionVC = QuestionViewController()
    let archiveVC = ArchiveMainViewController()
    let myinfoVC = MyInfoMainViewController()
    
    let homeTabBarItem = UITabBarItem(title: "홈", image: UIImage(named: ImgName.imgName(of: .homeIcon)), tag: 0)
    let questionTabBarItem = UITabBarItem(title: "Q&A", image: UIImage(named: ImgName.imgName(of: .questionIcon)), tag: 2)
    let archiveTabBarItem = UITabBarItem(title: "기록", image: UIImage(named: ImgName.imgName(of: .archiveIcon)), tag: 1)
    let myinfoTabBarItem = UITabBarItem(title: "마이", image: UIImage(named: ImgName.imgName(of: .myInfoIcon)), tag: 3)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        // MARK: use KVC to change TabBar
        let tabBar = { () -> CustomTabBar in
            let tabBar = CustomTabBar()
            tabBar.delegate = self
            return tabBar
        }()
        self.setValue(tabBar, forKey: "tabBar")
        
        let homeNavVC = UINavigationController(rootViewController: homeVC)
        let questionNavVC = UINavigationController(rootViewController: questionVC)
        let archiveNavVC = UINavigationController(rootViewController: archiveVC)
        let myinfoNavVC = UINavigationController(rootViewController: myinfoVC)
        
        homeNavVC.tabBarItem = homeTabBarItem
        questionNavVC.tabBarItem = questionTabBarItem
        archiveNavVC.tabBarItem = archiveTabBarItem
        myinfoNavVC.tabBarItem = myinfoTabBarItem
        
        self.viewControllers = [
            homeNavVC,
            archiveNavVC,
            questionNavVC,
            myinfoNavVC
        ]
        
    }
    
    override func viewWillLayoutSubviews() {
        tabBar.tintColor = .tabBarBlue
        tabBar.items?[0].titlePositionAdjustment.horizontal = 15
        tabBar.items?[1].titlePositionAdjustment.horizontal = -15
        tabBar.items?[2].titlePositionAdjustment.horizontal = 15
        tabBar.items?[3].titlePositionAdjustment.horizontal = -15
    }

}

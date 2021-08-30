import UIKit

class CustomTabBarViewController: UITabBarController, UITabBarControllerDelegate {
    let data = Date()
    
    let homeVC = HomeMainViewController()
    let questionVC = QuestionViewController()
    let archiveVC = ArchiveMainViewController()
    let myinfoVC = MyInfoMainViewController()
    let archiveWriteVC = ArchiveWriteViewController()
    let homeTabBarItem = UITabBarItem(title: nil, image: UIImage(named: ImgName.imgName(of: .homeIcon)), tag: 0)
    let archiveTabBarItem = UITabBarItem(title: nil, image: UIImage(named: ImgName.imgName(of: .testIcon)), tag: 1)
    let questionTabBarItem = UITabBarItem(title: nil, image: UIImage(named: ImgName.imgName(of: .questionIcon)), tag: 2)
    let myinfoTabBarItem = UITabBarItem(title: nil, image: UIImage(named: ImgName.imgName(of: .defaultProfile)), tag: 3)

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

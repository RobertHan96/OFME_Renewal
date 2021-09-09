import UIKit

class CustomTabBarViewController: UITabBarController, UITabBarControllerDelegate {
    let data = Date()
    let image = UIImage(named: "new_test_icon")
    let homeVC = HomeMainViewController()
    let questionVC = QuestionViewController()
    let tesetVC = TestConceptMainViewController()
    let myinfoVC = MyInfoMainViewController()
    let archiveWriteVC = ArchiveWriteViewController()
    let homeTabBarItem = UITabBarItem(title: nil, image: UIImage(named: ImgName.imgName(of: .homeIcon)), tag: 0)
    let tesetTabBarItem = UITabBarItem(title: nil, image: UIImage(named: "new_test_icon"), tag: 1)
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
        tesetTabBarItem.badgeColor = .black
        self.tabBarController?.updateTabBarItem(tab: 1, image: image)
        tesetTabBarItem.image = image?.withRenderingMode(.alwaysOriginal)
        tesetTabBarItem.selectedImage = image

        let homeNavVC = UINavigationController(rootViewController: homeVC)
        let questionNavVC = UINavigationController(rootViewController: questionVC)
        let archiveNavVC = UINavigationController(rootViewController: tesetVC)
        let myinfoNavVC = UINavigationController(rootViewController: myinfoVC)

        homeNavVC.tabBarItem = homeTabBarItem
        questionNavVC.tabBarItem = questionTabBarItem
        tesetVC.tabBarItem = tesetTabBarItem
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

extension UITabBarController {

    func updateTabBarItem(tab: Int, image: UIImage?) {

        guard let tabItems = tabBar.items, tab < tabItems.count && tab >= 0
            else { return }

        let tabItem = tabItems[tab]
        tabItem.image = image?.withRenderingMode(.alwaysOriginal)
        tabItem.selectedImage = tabItem.image

    }

}

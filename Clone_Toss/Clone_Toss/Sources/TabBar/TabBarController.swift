//
//  TabBarController.swift
//  Clone_Toss
//
//  Created by 한상진 on 2022/07/14.
//

import UIKit
import SnapKit
import Then

final class TabBarController: UITabBarController {
    private let homeViewController = HomeViewController().then {
        $0.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house"), selectedImage: UIImage(named: "house.fill")?.withRenderingMode(.alwaysOriginal))
    }
    private let benefitViewController = TempViewController().then {
        $0.tabBarItem = UITabBarItem(title: "혜택", image: UIImage(systemName: "diamond"), selectedImage: UIImage(named: "diamond.fill")?.withRenderingMode(.alwaysOriginal))
    }
    private let sendViewController = TempViewController().then {
        $0.tabBarItem = UITabBarItem(title: "송금", image: UIImage(systemName: "dollarsign.circle"), selectedImage: UIImage(named: "dollarsign.circle.fill")?.withRenderingMode(.alwaysOriginal))
    }
    private let stockViewController = TempViewController().then {
        $0.tabBarItem = UITabBarItem(title: "주식", image: UIImage(systemName: "chart.bar"), selectedImage: UIImage(named: "chart.bar.fill")?.withRenderingMode(.alwaysOriginal))
    }
    private let allViewController = TempViewController().then {
        $0.tabBarItem = UITabBarItem(title: "전체", image: UIImage(systemName: "line.3.horizontal"), selectedImage: UIImage(named: "line.3.horizontal.fill")?.withRenderingMode(.alwaysOriginal))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
}

private extension TabBarController {
    private func setupTabBar() {
        tabBar.tintColor = .black
        tabBar.backgroundColor = .white
        tabBar.layer.cornerRadius = 20
        tabBar.layer.borderWidth = 0.3
        tabBar.layer.borderColor = UIColor.lightGray.cgColor
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)], for: .selected)
        
        
        let homeNaviController = UINavigationController(rootViewController: homeViewController)
        let benefitNaviController = UINavigationController(rootViewController: benefitViewController)
        let sendNaviController = UINavigationController(rootViewController: sendViewController)
        let stockNaviController = UINavigationController(rootViewController: stockViewController)
        let allNaviController = UINavigationController(rootViewController: allViewController)
        
        setViewControllers([homeNaviController, benefitNaviController, sendNaviController, stockNaviController, allNaviController], animated: false)
    }
}

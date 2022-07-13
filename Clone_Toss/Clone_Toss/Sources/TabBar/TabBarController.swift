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
        $0.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house"), selectedImage: UIImage(named: "house.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.red))
        $0.navigationItem.largeTitleDisplayMode = .always
    }
    private let benefitViewController = TempViewController().then {
        $0.tabBarItem = UITabBarItem(title: "혜택", image: UIImage(systemName: "diamond"), selectedImage: UIImage(named: "diamond.fill")?.withRenderingMode(.alwaysOriginal))
        $0.navigationItem.largeTitleDisplayMode = .always
    }
    private let sendViewController = TempViewController().then {
        $0.tabBarItem = UITabBarItem(title: "송금", image: UIImage(systemName: "dollarsign.circle"), selectedImage: UIImage(named: "dollarsign.circle.fill")?.withRenderingMode(.alwaysOriginal))
        $0.navigationItem.largeTitleDisplayMode = .always
    }
    private let stockViewController = TempViewController().then {
        $0.tabBarItem = UITabBarItem(title: "주식", image: UIImage(systemName: "chart.bar"), selectedImage: UIImage(named: "chart.bar.fill")?.withRenderingMode(.alwaysOriginal))
        $0.navigationItem.largeTitleDisplayMode = .always
    }
    private let allViewController = TempViewController().then {
        $0.tabBarItem = UITabBarItem(title: "전체", image: UIImage(systemName: "line.3.horizontal"), selectedImage: UIImage(named: "line.3.horizontal.fill")?.withRenderingMode(.alwaysOriginal))
        $0.navigationItem.largeTitleDisplayMode = .always
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
}

private extension TabBarController {
    private func setupTabBar() {
        tabBar.tintColor = .black
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)], for: .selected)
        tabBar.layer.cornerRadius = 20
        tabBar.layer.borderWidth = 0.5
        tabBar.layer.borderColor = UIColor.lightGray.cgColor
        
        let homeNaviController = UINavigationController(rootViewController: homeViewController)
        let benefitNaviController = UINavigationController(rootViewController: benefitViewController)
        let sendNaviController = UINavigationController(rootViewController: sendViewController)
        let stockNaviController = UINavigationController(rootViewController: stockViewController)
        let allNaviController = UINavigationController(rootViewController: allViewController)
        
        setViewControllers([homeNaviController, benefitNaviController, sendNaviController, stockNaviController, allNaviController], animated: false)
    }
}

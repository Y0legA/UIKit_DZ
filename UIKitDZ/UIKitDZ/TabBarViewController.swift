//
//  TabBarViewController.swift
//  UIKitDZ
//
//  Created by Oleg_Yakovlev on 21.09.22.
//

import UIKit

// Экран таббара
final class TabBarViewController: UITabBarController {
    private enum Constants {
        static let titles = ["Storydoard", "Code NSConstraint", "Code NSLAnchor", "Code Stack View", "VFL"]
        static let main = "Main"
        static let identifier = "firstTrafficLightViewController"
    }
    
    // MARK: - Private Visual Components
    private let secondTrafficLightViewController = SecondTrafficLightViewController()
    private let thirdTrafficLightViewController = ThirdTrafficLightViewController()
    private let fourthTrafficLightViewController = FourthTrafficLightViewController()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureControllers()
    }
    
    // MARK: - Private Methods
    private func configureControllers() {
        tabBar.unselectedItemTintColor = .systemGray2
        let firstViewController = UIStoryboard(name: Constants.main, bundle: nil)
            .instantiateViewController(withIdentifier: Constants.identifier)
        viewControllers = [firstViewController
                           , secondTrafficLightViewController
                           , thirdTrafficLightViewController
                           , fourthTrafficLightViewController]
        guard let viewControllers = self.viewControllers else { return }
        for (index, controller) in viewControllers.enumerated() {
            controller.tabBarItem = UITabBarItem(title: Constants.titles[index], image: nil, tag: index)
        }
    }
}

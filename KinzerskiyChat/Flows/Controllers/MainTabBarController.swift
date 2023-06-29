//
//  MainTabBarController.swift
//  KinzerskiyChat
//
//  Created by Mac Pro on 26.06.2023.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let peopleViewController = PeopleViewController()
        let listViewController = ListViewController()
        tabBar.tintColor = #colorLiteral(red: 0.5568627451, green: 0.3529411765, blue: 0.968627451, alpha: 1)
        
        
        let boldConfiguration = UIImage.SymbolConfiguration(weight: .medium)
        let convImage = UIImage(systemName: "bubble.left.and.bubble.right", withConfiguration: boldConfiguration)!
        let peopleImage = UIImage(systemName: "person.2", withConfiguration: boldConfiguration)!
       
        
         viewControllers = [
            generateNavigationController(rootViewController: peopleViewController, title: "People", image: peopleImage),
            generateNavigationController(rootViewController: listViewController, title: "Conversation", image: convImage),
           ]
    }
    
    
    private func generateNavigationController(rootViewController: UIViewController, title: String, image: UIImage) ->  UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC
    }
}

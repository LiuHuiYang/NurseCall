//
//  SHMainViewController.swift
//  NurseCall
//
//  Created by Apple on 2019/3/15.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class SHMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 添加所有的子控制器
        setupChildControllers()

        tabBar.barTintColor = UIColor(white: 237.0/255.0, alpha: 1.0)
    }
}


// MARK: - 设置子控制器
extension SHMainViewController {
    
    /// 添加所有的子控制器
    private func setupChildControllers() {
        
        // 主要的控制器字典数组
        let controllerDictonaryArray = [
            
            ["className" : "SHUrgentViewController",
             "title": "Urgent",
             "imageName": "tabbar_urgent"
            ],
            
            ["className" : "SHNurseStationViewController",
             "title": "NurseStation",
             "imageName": "tabbar_nurstation"
            ],
            
            ["className" : "SHSickRoomViewController",
             "title": "SickRoom",
             "imageName": "tabbar_sickroom"
            ],
            
            ["className" : "SHSettingViewController",
             "title": "Setting",
             "imageName": "tabbar_setting"
            ],
        ]
        
        var childControllers = [UIViewController]()
        
        for dictionary in controllerDictonaryArray {
            
            childControllers.append(setupController(dictionary))
        }
        
        viewControllers = childControllers
    }
    
    /// 创建子控制器
    ///
    /// - Parameter dictionary: 字典信息
    /// - Returns: 控制器
    private func setupController(_ dictionary: [String: String]) -> UIViewController {
        
        guard let className = dictionary["className"],
            let title = dictionary["title"],
            let imageName = dictionary["imageName"],
            let controllerClass = NSClassFromString(Bundle.namespace + "." + className) as? UIViewController.Type
            else {
                
                return UIViewController()
        }
        
        var viewController = controllerClass.init()
        
        if className == "SHSettingViewController" {
            
            viewController =
                UIStoryboard(name: "SHSettingViewController",
                             bundle: nil
                    ).instantiateInitialViewController() ?? UIViewController()
        }
        
        viewController.title = title
        
        viewController.tabBarItem.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor:
                tabBarFontNormalColor as Any,
             NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13.0)],
            for: .normal
        )
        
        viewController.tabBarItem.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor:
                tabBarFonthighlightedColor as Any ],
            for: .selected
        )
        
        viewController.tabBarItem.image = UIImage(named: imageName)
        viewController.tabBarItem.selectedImage =
            UIImage(named: imageName +
                "_highlighted")?.withRenderingMode(.alwaysOriginal)
        
        let navigationViewController =
            SHNavigationController(rootViewController: viewController)
        
        return navigationViewController
    }
}

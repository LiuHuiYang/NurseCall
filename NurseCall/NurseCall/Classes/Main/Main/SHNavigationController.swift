//
//  SHNavigationController.swift
//  NurseCall
//
//  Created by Apple on 2019/3/15.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class SHNavigationController: UINavigationController {
    
    /// 状态栏样式
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
 
        /// 导航栏的字体
        let navigationBarFont: UIFont =
            UIFont.boldSystemFont(ofSize: 20)

        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: navigationBarFont,

            NSAttributedString.Key.foregroundColor:
               UIColor.white
        ]
        
        navigationBar.barTintColor =
            UIColor.color(colorHex: 0x1177EE)
    }
}


// MARK: - 导航栏的返回
extension SHNavigationController {
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if children.count > 0 {
            
            viewController.hidesBottomBarWhenPushed = true
            
            viewController.navigationItem.leftBarButtonItem =
                UIBarButtonItem(title: nil,
                                font: nil,
                                normalTextColor: nil,
                                highlightedTextColor: nil,
                                imageName: "back_navigation_bar",
                                hightlightedImageName: "back_navigation_bar",
                                addTarget: self,
                                action: #selector(popBack),
                                isNavigationBackItem:true
            )
            
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    
    /// 出栈
    @objc private func popBack() {
        popViewController(animated:true)
    }
}

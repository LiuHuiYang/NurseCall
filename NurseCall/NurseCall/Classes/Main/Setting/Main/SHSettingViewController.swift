//
//  SHSettingViewController.swift
//  NurseCall
//
//  Created by Apple on 2019/3/18.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import TYAlertController
import SAMKeychain
import SVProgressHUD


class SHSettingViewController: UITableViewController {
    
    /// 属性值输入框（中间过渡）
    private var valueTextField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor.white
        
        tableView.sectionHeaderHeight = 20
        tableView.sectionFooterHeight = 0
        
        // 分组样式的第一个cell的默认y值是35，要想间距为20，必须上移15，
        // 但这个上移应该是内容视图整体的上移，应该调整tableview头部的内边距
        tableView.contentInset =
            UIEdgeInsets(top: -15, left: 0, bottom: 0, right: 0);
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
            
        case 0:
            let callController = SHCallDeviceSettingViewController(deviceType: .call)
            navigationController?.pushViewController(
                callController,
                animated: true
            )
            
        case 1:
            let callController = SHCallDeviceSettingViewController(deviceType: .response)
            navigationController?.pushViewController(
                callController,
                animated: true
            ) 
            
        case 2:
            logout()
            
        case 3:
            let aboutController = SHAboutViewController()
            navigationController?.pushViewController(
                aboutController, animated: true
            )
            
        default:
            break
        }
    }
    
    
    /// 退出登录
    private func logout() {
        
        let alertView =
            SHTAlertView.setupAlertView(
                "Are you sure you want to log out?",
                message: "",
                isCustom: true
        )
        
        alertView.addTextField(configurationHandler: { (textField) in
            
            textField?.becomeFirstResponder()
            textField?.clearButtonMode = .whileEditing
            textField?.textAlignment = .center
         
            textField?.placeholder = "Please input a password"
            textField?.keyboardType = .default
            
            self.valueTextField = textField
        })
        
        let cancelAction =
            TYAlertAction(title: "Cancel",
                          style: .cancel,
                          handler: nil
        )
        
        alertView.add(cancelAction)
        
        let sureAction = TYAlertAction(title: "Sure", style: .default) { (action) in
            
            // 获得密码
            guard let inputPassword = self.valueTextField?.text,
                let passwordString = SAMKeychain.password(
                    forService: accountTest,
                    account: accountTest) ,
            
                inputPassword == passwordString else {
                    
                SVProgressHUD.showError(
                    withStatus: "Password error"
                )
                
                return
            }
            
            UserDefaults.standard.set(false, forKey: isLoginKey)
            UserDefaults.standard.synchronize()
            
            UIApplication.shared.keyWindow?.rootViewController =
                SHLoginViewController()
        }
        
        alertView.add(sureAction)
        
        
        let alertController =
            TYAlertController(alert: alertView,
                              preferredStyle: .alert,
                              transitionAnimation: .scaleFade
        )
        
        if UIDevice.is3_5inch() || UIDevice.is4_0inch() {
            
            alertController?.alertViewOriginY =
                navigationBarHeight + statusBarHeight
        }
        
        UIApplication.shared.keyWindow?.rootViewController?.present(
            alertController!,
            animated: true,
            completion: nil
        )
        
    }
}


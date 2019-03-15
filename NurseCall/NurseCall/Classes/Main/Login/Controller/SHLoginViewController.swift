//
//  SHLoginViewController.swift
//  NurseCall
//
//  Created by Apple on 2019/3/15.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import SVProgressHUD

class SHLoginViewController: SHViewController {
    
    
    /// 登录账号
    @IBOutlet weak var accountTextField: UITextField!
    
    /// 密码
    @IBOutlet weak var passwordTextField: UITextField!
    
    /// 登录按钮
    @IBOutlet weak var signinButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Hospital Call System"
        
        // 键盘的启动与回收
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyBoardWillShow(_:)),
            name:UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyBoardWillHide(_:)),
            name:UIResponder.keyboardWillHideNotification,
            object: nil
        )
        
        
        
        //        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        //        leftView.backgroundColor = UIColor.red
        //
        //        accountTextField.leftView = leftView
    }
    
    deinit {
        
        NotificationCenter.default.removeObserver(self)
    }
}


// MARK: - 键盘的通知处理
extension SHLoginViewController {
    
    @objc private func keyBoardWillShow(_ notification: Notification) {
        
        guard let info = notification.userInfo,
            let keyboardSize =
                info[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
            let duration =
            info[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
            
            else {
            
            return
        }
        
        
        // 计算距离
        let offsetY = keyboardSize.origin.y
        
        print("移动距离: \(offsetY)")
        
        // 动画移动
        UIView.animate(withDuration: duration) {

        }
        
 
//        //键盘的y偏移量
//        let offsetY = kbRect.origin.y - UIScreen.main.bounds.height
 

    }
    
    
    /// 键盘消失
    ///
    /// - Parameter notification: notification description
    @objc private func keyBoardWillHide(_ notification: Notification) {
        
        
    }
}


// MARK: - 登录处理
extension SHLoginViewController {
    
    @IBAction func signinButtonClick() {
        
        guard let accout = accountTextField.text,
            let password = passwordTextField.text else {
                
                SVProgressHUD.showError(
                    withStatus: "Error in account or password"
                )
                
                return
        }
        
        // 比较账号与密码(临时测试)
        if accout == "root" &&
            password == "root" {
            
            // 正在登录
            SVProgressHUD.show(withStatus: "Logging ...")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute:{
                
                SVProgressHUD.dismiss()
                
                // 设置成功登录标志
                UserDefaults.standard.set(true, forKey: isLoginKey)
                UserDefaults.standard.synchronize()
                
                // 切换控制器
                UIApplication.shared.keyWindow?.rootViewController =
                    SHMainViewController()
            })
            
            
        } else {
            
            SVProgressHUD.showError(
                withStatus: "Error in account or password"
            )
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute:{
                
                SVProgressHUD.dismiss()
                
                self.accountTextField.text = nil
                self.passwordTextField.text = nil
                
                self.accountTextField.becomeFirstResponder()
            })
        }
    }
}

// MARK: - UITextFieldDelegate
extension SHLoginViewController : UITextFieldDelegate {
    
    /// 确定点击
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == accountTextField {
            
            accountTextField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            
            passwordTextField.resignFirstResponder()
            
            signinButtonClick()
        }
        
        return true
    }
}

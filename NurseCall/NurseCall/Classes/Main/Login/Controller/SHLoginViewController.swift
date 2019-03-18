//
//  SHLoginViewController.swift
//  NurseCall
//
//  Created by Apple on 2019/3/15.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import SVProgressHUD
import SAMKeychain

// 临时使用的测试账号与密码
private let accountTest = "admin"
private let passwordTest = "123456"

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
        
        // 登录账号与密码框的初始化
        accountTextField.leftViewMode = .always
        passwordTextField.leftViewMode = .always
        
        let bounds = CGRect(x: 0, y: 0, width: 30, height: 30)
    
        let accoutIconView = UIImageView(frame: bounds)
        accoutIconView.image = UIImage(named: "login_account")
        
        let passwordIconView = UIImageView(frame: bounds)
        passwordIconView.image = UIImage(named: "login_password")
    
        accountTextField.leftView = accoutIconView
        passwordTextField.leftView = passwordIconView
        
        accountTextField.tintColor = tabBarFontNormalColor
        passwordTextField.tintColor = tabBarFontNormalColor
        
        accountTextField.becomeFirstResponder()
    }
    
    deinit {
        
        NotificationCenter.default.removeObserver(self)
    }
}


// MARK: - 键盘的通知处理
extension SHLoginViewController {
    
    @objc private func keyBoardWillShow(_ notification: Notification) {
        
        print("键盘出现 \(view.frame.origin.y)")
        
        if view.frame.origin.y != 0 {
//            return
        }
        
        guard let info = notification.userInfo,
            let keyboardSize =
                info[UIResponder.keyboardFrameEndUserInfoKey] as?CGRect,
            let duration =
            info[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
            
            else {
            
            return
        }
        
        let maxY = signinButton.frame.maxY - 64
        let marign = keyboardSize.height
        let offsetY = maxY - marign
        print("键盘移动\(maxY) \(marign) \(offsetY)")
        
        view.transform.translatedBy(x: 0, y: -100)
        
        
        
        // 动画移动
        UIView.animate(withDuration: duration) {

//            self.view.frame.origin.y = 0 - keyboardSize.height
//            self.accountTextField.frame.origin.y -=
//                keyboardSize.height
            
//            self.view.frame.origin.y -= offsetY
//            self.view.layoutIfNeeded()
        }
        
        
    }
    
    
    /// 键盘消失
    ///
    /// - Parameter notification: notification description
    @objc private func keyBoardWillHide(_ notification: Notification) {
        
        if view.frame.origin.y == 0 {
            return
        }
        
        print("键盘消失 \(view.frame.origin.y)")
        
        guard let info = notification.userInfo,
//            let keyboardSize =
//            info[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
            let duration =
            info[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
            
            else {
                
                return
        }
        
        // 动画移动
        UIView.animate(withDuration: duration) {
            
            self.view.frame.origin.y = 0
        }
    }
}


// MARK: - 登录处理
extension SHLoginViewController {
    
    @IBAction func signinButtonClick() {
        
        view.endEditing(true)
        return
        
        guard let accout = accountTextField.text,
            let password = passwordTextField.text else {
                
                SVProgressHUD.showError(
                    withStatus: "Error in account or password"
                )
                
                return
        }
        
        view.endEditing(true)
        
        // 比较账号与密码(临时测试)
        if accout == accountTest &&
            password == passwordTest {
            
            // 正在登录
            SVProgressHUD.show(withStatus: "Logging ...")
            
            // 延时2s切换
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute:{
                
                SVProgressHUD.dismiss()
                
                // 设置成功登录标志
                UserDefaults.standard.set(true, forKey: isLoginKey)
                UserDefaults.standard.synchronize()
                
                // 保存密码
                SAMKeychain.setPassword(
                    password,
                    forService: accout,
                    account: accout
                )
                
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

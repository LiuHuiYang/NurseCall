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
        
      
        //左侧图片
        let leftView = UIImageView(image: #imageLiteral(resourceName: "back_navigation_bar"))
        leftView.contentMode = .center
        
        //添加背景视图
        let bgView = UIView()
        bgView.backgroundColor = UIColor.clear
        bgView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
//        bgView.addSubview(leftView)
//        leftView.snp.makeConstraints { (make) in
//            make.center.equalTo(bgView)
//            make.width.height.equalTo(15)
//        }
        
        accountTextField.leftView = bgView
        
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

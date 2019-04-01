//
//  SHSickRoomViewController.swift
//  NurseCall
//
//  Created by Apple on 2019/3/29.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class SHSickRoomViewController: SHViewController {
    
    
    /// 设置按钮
    @IBOutlet weak var settingButton: UIButton!
    
    
    /// 设置View
    @IBOutlet weak var settingView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /// 设置按钮点击
    @IBAction func settingButtonClick() {
        
        printLog(message: "点击按钮")
        
        UIView.animate(withDuration: 0.3) {
            
            self.settingButton.isSelected =
                !self.settingButton.isSelected
            
            self.settingView.isHidden = !self.settingView.isHidden
            
        }
    }
    
}

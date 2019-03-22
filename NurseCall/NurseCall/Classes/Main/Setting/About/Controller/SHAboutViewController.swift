//
//  SHAboutViewController.swift
//  NurseCall
//
//  Created by Apple on 2019/3/18.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class SHAboutViewController: SHViewController {
    
    /// 关于详细Label
    @IBOutlet weak var aboutDetailLabel: UILabel!
    
    /// 关于
    @IBOutlet weak var aboutDetailHeightConstraint: NSLayoutConstraint!
    
    
    /// 同意声明Label
    @IBOutlet weak var agreementLabel: UILabel!
    
    /// 同意声明的Label
    @IBOutlet weak var agreementLabelHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "About"
        
        aboutDetailLabel.text =
            "Version: 1.0 \n" +
            "Date: 15 Mar 2019 \n" +
            "OS: iOS 9.0 or Higher \n" +
            "Control System: SmartG4 Control Automation \n" +
            "Protocol: Smart BUS/S-BUS/SBUS \n" +
            "Developer Country: USA \n" +
            "Developper: \n " +
            "   SMART INDUSTRY GROUP"
        
        
        agreementLabel.text =
            "  This App is Free App.The Developper Has no Responsibility Nor Liability Regarding any Claim nor any Damages.it is an antomatic acceptance by user and any company they represent or related to that accept current rules and conditions of developper.User once install or use this App it represents is an Automatic acceptance of current weiver and acceptance to any future conditions and rules change."
    }

 
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        // 计算高度
        
        let font = UIFont.systemFont(ofSize: 16)
        let size =
            CGSize(width: view.frame_width - 30,
                          height: CGFloat(MAXFLOAT)
        )
        
        if let aboutText = aboutDetailLabel.text as NSString? {
            
            let height =
                aboutText.boundingRect(
                    with: size,
                    options: .usesLineFragmentOrigin,
                    attributes: [NSAttributedString.Key.font : font],
                    context: nil
                ).size.height
          
            aboutDetailHeightConstraint.constant = height
        }
        
        if let agreementText = agreementLabel.text as NSString? {
            
            let height =
                agreementText.boundingRect(
                    with: size,
                    options: .usesLineFragmentOrigin,
                    attributes: [NSAttributedString.Key.font : font],
                    context: nil
                ).size.height
    
            agreementLabelHeightConstraint.constant = height
        }
    }
}

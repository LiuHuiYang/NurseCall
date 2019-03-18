//
//  SHDeviceManagerCell.swift
//  NurseCall
//
//  Created by Apple on 2019/3/18.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class SHDeviceManagerCell: UICollectionViewCell {
    
    /// 呼叫设备
    var device: SHDevice?
    
    
    /// 关闭按钮
    @IBOutlet weak var closeButton: UIButton!
    
    /// 类型标示
    @IBOutlet weak var iconView: UIImageView!
    
    /// 子网ID
    @IBOutlet weak var subNetIDTextField: UITextField!
    
    /// 设备ID
    @IBOutlet weak var deviceIDTextField: UITextField!
    
    
    /// 名称
    @IBOutlet weak var nameTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    /// 关闭按钮点击
    @IBAction func closeButtonClick() {
        
        
    }
    
}

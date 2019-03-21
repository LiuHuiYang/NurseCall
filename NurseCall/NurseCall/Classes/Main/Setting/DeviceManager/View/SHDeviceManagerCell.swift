//
//  SHDeviceManagerCell.swift
//  NurseCall
//
//  Created by Apple on 2019/3/18.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import SVProgressHUD

class SHDeviceManagerCell: UICollectionViewCell {
    
    /// 呼叫设备
    var device: SHDevice? {
        
        didSet {
            
            subNetIDTextField.text = "\(device?.subNetID ?? 0)"
            deviceIDTextField.text = "\(device?.deviceID ?? 0)"
            nameTextField.text = device?.remark
        }
    }
    
    
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
        
        // 初始化
        subNetIDTextField.leftViewMode = .always
        subNetIDTextField.leftView?.contentMode = .scaleAspectFit
        
        deviceIDTextField.leftViewMode = .always
        deviceIDTextField.leftView?.contentMode = .scaleAspectFit
        
        nameTextField.leftViewMode = .always
        nameTextField.leftView?.contentMode = .scaleAspectFit
        
        let bounds = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        let subnetIconView = UIImageView(frame: bounds)
        subnetIconView.image = UIImage(named: "deviceID_setting")
        
        let deviceIconView = UIImageView(frame: bounds)
        deviceIconView.image = UIImage(named: "deviceID_setting")
        
        let remarkIconView = UIImageView(frame: bounds)
        remarkIconView.image = UIImage(named: "deviceRemark_setting")
        
        subNetIDTextField.leftView = subnetIconView
        deviceIDTextField.leftView = deviceIconView
        nameTextField.leftView = remarkIconView
        
        subNetIDTextField.tintColor = tabBarFontNormalColor
        deviceIDTextField.tintColor = tabBarFontNormalColor
        nameTextField.tintColor = tabBarFontNormalColor
        
        closeButton.isHidden = true
        
        // 监听通知
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(editDevice),
            name: NSNotification.Name(editDeviceNotification),
            object: nil
        )
    }
    
    
    /// 保存按钮点击
    @IBAction func saveButtonClick() {
        
        guard let equipment = device,
            let subNetID = UInt8(subNetIDTextField.text ?? "0"),
            let deviceID = UInt8(deviceIDTextField.text ?? "0"),
            let remark = nameTextField.text else {
                
            
            SVProgressHUD.showError(
                withStatus: "Data cannot be empty"
            )
                
            return
        }
        
        equipment.subNetID = subNetID
        equipment.deviceID = deviceID
        equipment.remark = remark
        
        _ = SHSQLiteManager.shared.updateCallDevice(equipment)
    }
    
    
    /// 关闭按钮点击
    @IBAction func closeButtonClick() {
        
        // 删除
        _ = SHSQLiteManager.shared.deleteCallDevice(device!)
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension SHDeviceManagerCell {
    
    @objc private func editDevice() {
    
        print("通知编辑")
        closeButton.isHidden = false
    }
}

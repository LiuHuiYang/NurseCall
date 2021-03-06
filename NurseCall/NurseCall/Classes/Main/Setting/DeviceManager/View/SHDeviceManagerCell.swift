//
//  SHDeviceManagerCell.swift
//  NurseCall
//
//  Created by Apple on 2019/3/18.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import SVProgressHUD

/// 设置配置重用标示符
let deviceSettingCellReuseIdentifier =
    "SHDeviceManagerCell"

class SHDeviceManagerCell: UICollectionViewCell {
    
    /// 呼叫设备
    var device: SHDevice? {
        
        didSet {
            
            // 去除重用机制的影响
            iconView.image = nil
            subNetIDTextField.text = nil
            deviceIDTextField.text = nil
            nameTextField.text = nil
            
            iconView.image =
                device?.deviceType == .call ?
                    UIImage(named: "callDevice_setting") :
                    UIImage(named: "respondDevice_setting")
            
            
            if let subNetID = device?.subNetID,
                let deviceID = device?.deviceID,
                subNetID != 0,
                deviceID != 0 {
                    
                subNetIDTextField.text = "\(subNetID)"
                deviceIDTextField.text = "\(deviceID)"
                nameTextField.text = device?.remark
            }
            
        }
    }
    
    /// 回调
    var callBack: (() -> ())?
    
    /// 默认高度
    static var itemHeight: CGFloat {
        
        return 7 * tabBarHeight
    }
    
    /// 保存按钮
    @IBOutlet weak var saveButton: UIButton!
    
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
        
        isUserInteractionEnabled = false
        
        layer.cornerRadius = statusBarHeight * 0.5
        clipsToBounds = true
        
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
        saveButton.isHidden = true
        
        // 监听通知
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(startEditDevice),
            name: NSNotification.Name(editDeviceStartNotification),
            object: nil
        )
        
        // 监听通知
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(finishEditDevice),
            name: NSNotification.Name(editDeviceEndNotification),
            object: nil
        )
    }
    
    
    /// 保存按钮点击
    @IBAction func saveButtonClick() {
        
        guard let equipment = device,
            let subNetID = UInt8(subNetIDTextField.text ?? "0"),
            let deviceID = UInt8(deviceIDTextField.text ?? "0"),
            let remark = nameTextField.text,
            subNetID != 0,
            deviceID != 0,
            !remark.isEmpty else {
                
                SVProgressHUD.showError(
                    withStatus: "invalid data"
                )
                
                return
        }
        
        equipment.subNetID = subNetID
        equipment.deviceID = deviceID
        equipment.remark = remark
        
        if SHSQLiteManager.shared.updateDevice(equipment) {
            
            NotificationCenter.default.post(
                name: Notification.Name(editDeviceEndNotification),
                object: nil
            )
            
            // 执行闭包
            callBack?()
        }
        
    }
    
    
    /// 关闭按钮点击
    @IBAction func closeButtonClick() {
          
        // 删除
        if SHSQLiteManager.shared.deleteDevices(device!) {
            
            SVProgressHUD.showSuccess(
                withStatus: "Successful device deletion"
            )
            
            NotificationCenter.default.post(
                name: Notification.Name(editDeviceEndNotification),
                object: nil
            )
            
            // 执行闭包
            callBack?()
        }
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}


// MARK: - 编辑
extension SHDeviceManagerCell {
    
    @objc private func startEditDevice() {
        
        isUserInteractionEnabled = true
        closeButton.isHidden = false
        saveButton.isHidden = false
        
    }
    
    @objc private func finishEditDevice() {
        
        endEditing(true)
        
        isUserInteractionEnabled = false
        closeButton.isHidden = true
        saveButton.isHidden = true
    }
}


// MARK: - textField代理fdf
extension SHDeviceManagerCell : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == subNetIDTextField {
            
            print("子网ID")
            
        } else if textField == deviceIDTextField {
            
            print("设备ID")
            
        } else if textField == nameTextField {
            
            print("名称")
        }
    }
}

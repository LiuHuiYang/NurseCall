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
            
            guard let subNetID = device?.subNetID,
                let deviceID = device?.deviceID,
                subNetID != 0,
                deviceID != 0 else {
                
                return
            }
            
            subNetIDTextField.text = "\(subNetID)"
            deviceIDTextField.text = "\(deviceID)"
            nameTextField.text = device?.remark
        }
    }
    
    var callBack: (() -> ())?
    
    
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
        
        _ = SHSQLiteManager.shared.updateCallDevice(equipment)
        
        endEditing(true)
        closeButton.isHidden = true
        isUserInteractionEnabled = false
    }
    
    
    /// 关闭按钮点击
    @IBAction func closeButtonClick() {
        
        // 删除
        if SHSQLiteManager.shared.deleteCallDevice(device!) {
            
            SVProgressHUD.showSuccess(
                withStatus: "Successful device deletion"
            )
            
            // 执行闭包
            callBack?()
        }
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension SHDeviceManagerCell {
    
    @objc private func editDevice() {
    
        isUserInteractionEnabled = true
        print("通知编辑")
        closeButton.isHidden = false
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

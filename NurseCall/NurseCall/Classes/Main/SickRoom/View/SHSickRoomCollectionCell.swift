//
//  SHSickRoomCollectionCell.swift
//  NurseCall
//
//  Created by Apple on 2019/4/3.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class SHSickRoomCollectionCell: UICollectionViewCell {
    
    /// 病房
    var sickRoom: SHSickRoom? {
        
        didSet {
            
            // 去除重用机制的影响
            iconView.image = nil
            roomTextField.text = nil
            nameTextField.text = nil
            
            iconView.image = UIImage(named: "sickroom")
            
//            iconView.image =
//                device?.deviceType == .call ?
//                    UIImage(named: "callDevice_setting") :
//                UIImage(named: "respondDevice_setting")
            
            
//            if let subNetID = device?.subNetID,
//                let deviceID = device?.deviceID,
//                subNetID != 0,
//                deviceID != 0 {
//
//                roomTextField.text = "\(subNetID)"
//                nameTextField.text = device?.remark
//            }
            
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
    
    /// 楼层
    @IBOutlet weak var roomTextField: UITextField!
    
    
    /// 备注名称
    @IBOutlet weak var nameTextField: UITextField!
    

   

    /// 保存按钮点击
    @IBAction func saveButtonClick() {
        
//        guard let equipment = device,
//            let subNetID = UInt8(roomTextField.text ?? "0"),
//            let remark = nameTextField.text,
//            subNetID != 0,
//            deviceID != 0,
//            !remark.isEmpty else {
//
//                SVProgressHUD.showError(
//                    withStatus: "invalid data"
//                )
//
//                return
//        }
//
//        equipment.subNetID = subNetID
//        equipment.deviceID = deviceID
//        equipment.remark = remark
//
//        if SHSQLiteManager.shared.updateCallDevice(equipment) {
//
//            NotificationCenter.default.post(
//                name: Notification.Name(editDeviceEndNotification),
//                object: nil
//            )
//
            // 执行闭包
            callBack?()
//        }
        
    }
    
    
    /// 关闭按钮点击
    @IBAction func closeButtonClick() {
        
//        // 删除
//        if SHSQLiteManager.shared.deleteCallDevice(device!) {
//
//            SVProgressHUD.showSuccess(
//                withStatus: "Successful device deletion"
//            )
//
//            NotificationCenter.default.post(
//                name: Notification.Name(editDeviceEndNotification),
//                object: nil
//            )
//
            // 执行闭包
            callBack?()
//        }
    }
    
    
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - 编辑
extension SHSickRoomCollectionCell {
    
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

extension SHSickRoomCollectionCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        isUserInteractionEnabled = false
        
        layer.cornerRadius = statusBarHeight * 0.5
        clipsToBounds = true
        
        // 初始化
        roomTextField.leftViewMode = .always
        roomTextField.leftView?.contentMode = .scaleAspectFit
        
        nameTextField.leftViewMode = .always
        nameTextField.leftView?.contentMode = .scaleAspectFit
        
        let bounds = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        let subnetIconView = UIImageView(frame: bounds)
        subnetIconView.image = UIImage(named: "floor")
        subnetIconView.contentMode = .scaleAspectFit
        
        
        let remarkIconView = UIImageView(frame: bounds)
        remarkIconView.image = UIImage(named: "name")
        remarkIconView.contentMode = .scaleAspectFit
        
        roomTextField.leftView = subnetIconView
        nameTextField.leftView = remarkIconView
        
        roomTextField.tintColor = tabBarFontNormalColor
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
}

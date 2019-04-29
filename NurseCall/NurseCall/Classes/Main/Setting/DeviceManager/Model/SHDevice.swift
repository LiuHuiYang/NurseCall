//
//  SHCallDevice.swift
//  NurseCall
//
//  Created by Apple on 2019/3/18.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

@objc enum SHDeviceType: UInt {
    
    case call = 10001
    case response
}

/// 设备 kvc 使用了 runtime 所以要加上 objcMembers
@objcMembers class SHDevice: NSObject {

    /// 自增ID
    var id: UInt = 0
    
    /// 子网ID
    var subNetID: UInt8 = 0
    
    /// 设备ID
    var deviceID: UInt8 = 0
    
    /// 标注说明
    var remark: String = ""
    
    /// 设备类型
    var deviceType: SHDeviceType = .call
    
    override init() {
        super.init()
    }
    
    init(dictionary: [String: Any]) {
        
        super.init()
        setValuesForKeys(dictionary)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        //        print("设置: \(key) - \(value ?? "")")
        
        super.setValue(value, forKey: key)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
        //        if key == "ID" {
        
        //          id = UInt(value as? String ?? "0") ?? 0
        //            id = value as? UInt ?? 0
        //        }
         
        
        if key == "deviceType" {
            
            deviceType =
                SHDeviceType(
                    rawValue: UInt(value as? String ?? "0") ?? 0
            ) ?? .call
        }
    }
}

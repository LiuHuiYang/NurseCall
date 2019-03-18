//
//  SHDevice.swift
//  NurseCall
//
//  Created by Apple on 2019/3/18.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

// FIXME: - 这里有争议 - 以后再确定

enum SHDeviceManagerType: UInt {
    
    case call       // 呼叫设备
    case response   // 响应设备
}

/// 设备
class SHDevice: NSObject {
    
    /// 子网ID
    var subNetID: UInt8 = 0
    
    /// 设备ID
    var deviceID: UInt8 = 0
    
    /// 标注说明
    var remark: String = ""
    
    /// 楼层
    var floor: UInt = 0
    
    /// 房间
    var roomID: UInt = 0
    
    /// 床位号
    var bedID: UInt = 0
}

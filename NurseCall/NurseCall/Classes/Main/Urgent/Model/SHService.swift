//
//  SHService.swift
//  NurseCall
//
//  Created by Apple on 2019/4/4.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit


/// 服务
class SHService: NSObject {
    
    /// 请求服务的子网ID
    var subNetID: UInt8 = 0
    
    /// 请求服务的设备ID
    var deviceID: UInt8 = 0
    
    /// 服务名称
    var serviceName: String = ""
    
    /// 服务等级
    var serviceLevel: SHServiceLevel = .normal
    
    /// 服务状态
    var status: SHServiceStatus = .end

    /// 没有服务
    var serviceType: SHServiceType = .none {
        
        didSet {
            
            serviceName = SHServiceTools.serviceName(serviceType)
        }
    }
    
    /// 服务呼叫时间
    var serviceCallTime = Date.localTime()
    
    /// 服务响应时间
    var serviceAcknowledgeTime = Date.localTime()
    
    /// 服务开始时间
    var serviceStartTime = Date.localTime()
    
    /// 服务结束
    var serviceFinishedTime = Date.localTime()
    
    // 找到呼叫设备与响应设备
    
}

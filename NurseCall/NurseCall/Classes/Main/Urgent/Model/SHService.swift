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
    
    
    // 找到呼叫设备与响应设备
    
}

//
//  SHServiceTools.swift
//  NurseCall
//
//  Created by Apple on 2019/3/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import SVProgressHUD

class SHServiceTools: NSObject {
    
    /// 单例处理工具
    static var shared = SHServiceTools()
    
    /// 服务的缓存缓存
    static var caches = [SHService]()
    
    /// 所有的服务 == 这里应用使用cache
    lazy var services: [SHService] = {
        
        // 测试代码
        for i in 1 ... 8 {
            
            let service = SHService()
            service.serviceType =
                SHServiceType(rawValue: UInt8(i)) ?? .none
            
            if i & 1 == 0 {
                
                service.serviceLevel = .emergency
            }
            
            // 后来者居上
            SHServiceTools.createService(service)
        }
        
        return SHServiceTools.caches
    }()
}

extension SHServiceTools {
    
    /// 解析广播数据
    ///
    /// - Parameter scoketData: 广播数据
    static func receivingBroadcastData(_ socketData: SHSocketData) {
        
        // 不是呼叫服务不处理
        if socketData.operatorCode != 0x03B2 &&
           socketData.operatorCode != 0x03B3 {
            return
        }
        
        printLog(message: socketData)
        
        // 呼叫类型
        let callType = socketData.additionalData[0]
        
        // 服务状态
        let serviceStatus = socketData.additionalData[1]
        
        guard let serviceType = SHServiceType(rawValue: callType),
            let status = SHServiceStatus(rawValue: serviceStatus) else {
                
                return
        }
        
        // 创建新服务
        let receivedService = SHService()
        receivedService.subNetID = socketData.subNetID
        receivedService.deviceID = socketData.deviceID
        receivedService.serviceType = serviceType
        
        // 处理当前的响应时间
        switch status {
            
        case .new:
  
            receivedService.status = status
            receivedService.serviceCallTime = Date()
            
            // 保存在缓存中
            SHServiceTools.createService(
                receivedService
            )
            
            SVProgressHUD.showInfo(
                withStatus:
                    receivedService.serviceName + " ON"
            )
            
            
        case .acknowledge:
            
            // 查询服务
            if let service = SHServiceTools.selectService(receivedService) {
                
                // 更新值
                service.status = status
                service.serviceAcknowledgeTime = Date()
                
                SHServiceTools.updateService(
                    service
                )
                
                SVProgressHUD.showInfo(
                    withStatus:
                    receivedService.serviceName + " Call"
                )
            }
            
            
        case .on:
            
            // 查询服务
            if let service = SHServiceTools.selectService(receivedService) {
                
                // 更新值
                service.status = status
                service.serviceStartTime = Date()
                
                SHServiceTools.updateService(
                    service
                )
                
                SVProgressHUD.showInfo(
                    withStatus:
                    receivedService.serviceName + " On"
                )
            }
            
        case .end:
            
            
            // 查询服务
            if let service = SHServiceTools.selectService(receivedService) {
                
                // 更新值
                service.status = status
                service.serviceFinishedTime = Date()
                
                SHServiceTools.updateService(
                    service
                )
                
                // 从缓存中删除服务
                SHServiceTools.removeService(service)
                
                // 存入数据库
                
                
                SVProgressHUD.showInfo(
                    withStatus:
                    receivedService.serviceName + " Off"
                )
            }
        }
    }
}

// MARK: -
extension SHServiceTools {
    
    /// 服务状态的文字描述
    ///
    /// - Parameter status: 状态
    /// - Returns: 文字描述
    static func serviceStatus(_ status: SHServiceStatus) -> String {
        
        switch status {
            
        case .on:
            return "Serving"
            
        case .new:
            return "New"
            
        case .acknowledge:
            return "Pending"
            
        case .end:
            return "End"
            
//        default:
//            return ""
        }
    }
    
    /// 获得呼叫名称
    ///
    /// - Parameter serviceType: 呼叫类型
    /// - Returns: 文字描述
    static func serviceName(_ serviceType: SHServiceType) -> String {
        
        switch serviceType {
            
        case .none:
            return ""
        
        case .generalService:
            return "General"
        
        case .superEmergencyService:
            return "Doctor" // 将超紧急服务修改为叫医生
            
        case .nurseService:
            return "Nurse"
       
        case .pendService:
            return "Peinding"
            
        case .emergencyService: // 紧急服务
            return "Emergency"
        
        case .inService:
            return "Serving"
       
        case .thirstyService:
            return "Thirsty"
       
        case .sheetsService:
            return "Sheets"
        
        case .nurseBabyService:
            return "Nurse Baby"
        
        case .feelPainService:
            return "Pain"
        
        case .doctorService:
            return "Doctor"
        
        case .hungryService:
            return "Hungry"
       
        case .dressService:
            return "Dress"
        
        case .walkHelpService:
            return "Walk Help"
       
        case .feelHotService:
            return "Hot"
        
        case .guestSRVService:
            return "Guest SRV"
        
        case .toiletHelpService:
            return "Toilet Help"
        
        case .wheelchairService:
            return "Wheel Chair"
        
        case .feelColdService:
            return "Cold"
        }
    }
}

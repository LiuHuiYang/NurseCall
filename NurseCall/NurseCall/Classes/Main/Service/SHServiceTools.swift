//
//  SHServiceTools.swift
//  NurseCall
//
//  Created by Apple on 2019/3/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class SHServiceTools: NSObject {
    
    /// 单例处理工具
    static let shared = SHServiceTools()
    
    /// 服务缓存
    static let caches = NSCache<AnyObject, AnyObject>()
    
    /// 所有的服务 == 这里应用使用cache
    lazy var services: [SHService] = {
        
        var tests = [SHService]()
        
        // 测试代码
        for i in 1 ... 8 {
            
            let service = SHService()
            service.serviceType =
                SHServiceType(rawValue: UInt8(i)) ?? .none
            
            if i & 1 == 0 {
                
                service.serviceLevel = .emergency
            }
            
            // 后来者居上
            tests.insert(service, at: 0)
        }
        
        return tests
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
            receivedService.serviceCallTime = Date.localTime()
            
            // 保存在缓存中
            SHServiceTools.createOrUpdateService(
                receivedService
            )
            
        case .acknowledge:
            
            // 查询服务
            if let service = SHServiceTools.selectService(receivedService) {
                
                // 更新值
                service.status = status
                service.serviceAcknowledgeTime = Date.localTime()
                
                SHServiceTools.createOrUpdateService(
                    service
                )
            }
            
            
        case .on:
            
            // 查询服务
            if let service = SHServiceTools.selectService(receivedService) {
                
                // 更新值
                service.status = status
                service.serviceStartTime = Date.localTime()
                
                SHServiceTools.createOrUpdateService(
                    service
                )
            }
            
        case .end:
            
            
            // 查询服务
            if let service = SHServiceTools.selectService(receivedService) {
                
                // 更新值
                service.status = status
                service.serviceFinishedTime = Date.localTime()
                
                SHServiceTools.createOrUpdateService(
                    service
                )
                
                // 从缓存中删除服务
                SHServiceTools.removeService(service)
                
                // 存入数据库
            }
        }
        
        // 处理不同的服务类型
        switch serviceType {
            
        case .pendService:          // 护士站已有响应
            break
            
        case .generalService:       // 一般服务
            break
            
        case .inService:            // 护士在该病房中 服务中
            break
            
        case .emergencyService:     // 紧急服务
            break
            
        case .nurseService:         // 护理服务
            break
            
        case .thirstyService:         // 帮助喝水的服务
            break
            
        case .sheetsService:         // 整理床单服务
            break
            
        case .nurseBabyService:       // 婴儿看护服务
            break
            
        case .feelPainService:       // 感觉疼痛服务
            break
            
        case .doctorService:          // 医生服务
            break
            
        case .hungryService:          // 饥饿的服务
            break
            
        case .dressService:          // 穿衣服务
            break
            
        case .walkHelpService:        // 助行服务
            break
            
        case .feelHotService:         // 感觉热的服务
            break
            
        case .guestSRVService:        // SRV服务
            break
            
        case .toiletHelpService:      // 卫生服务
            break
            
        case .wheelchairService:      // 轮椅服务
            break
            
        case .feelColdService:        // 保暖的服务
            break
            
        case .superEmergencyService:  // 超紧急服务(设置为叫医生服务)
            break
            
        default:
            break
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

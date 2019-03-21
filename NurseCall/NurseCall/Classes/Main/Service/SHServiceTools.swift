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
    
    /// 解决广播数所
    ///
    /// - Parameter scoketData: 广播数据
    static func receivingBroadcastData(_ socketData: SHSocketData) {
        
        // 不是呼叫报务不工作
        if socketData.operatorCode != 0x03B2 &&
            socketData.operatorCode != 0x03B3 {
            return
        }
        
        print(socketData)
        
        // 呼叫类型
        let callType = socketData.additionalData[0]
        
        // 服务状态
        let serviceStatus = socketData.additionalData[1]
        
        guard let serviceType = SHServiceType(rawValue: callType),
            let status = SHServiceStatus(rawValue: serviceStatus) else {
                
                return
        }
        
        print(status)
        
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

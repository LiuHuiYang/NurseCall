//
//  SHServiceType.swift
//  NurseCall
//
//  Created by Apple on 2019/3/18.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation

// 服务类型

enum SHServiceType : UInt8 {
    
    case none                   // 没有服务
    
    case pendService            // 护士站已有响应
    
    case generalService         // 一般服务
    
    case emergencyService       // 紧急服务
    
    case inService              // 护士在该病房中 服务中
    
    case nurseService           // 护理服务
    
    case thirstyService         // 帮助喝水的服务
    
    case sheetsService          // 整理床单服务
    
    case nurseBabyService       // 婴儿看护服务
    
    case feelPainService        // 感觉疼痛服务
    
    case doctorService          // 医生服务
    
    case hungryService          // 饥饿的服务
    
    case dressService           // 穿衣服务
    
    case walkHelpService        // 助行服务
    
    case feelHotService         // 感觉热的服务
    
    case guestSRVService        // SRV服务
    
    case toiletHelpService      // 卫生服务
    
    case wheelchairService      // 轮椅服务
    
    case feelColdService        // 保暖的服务
    
    case superEmergencyService  // 超紧急服务(设置为叫医生服务)
}

// 服务的状态
enum SHServiceStatus : UInt8 {
    
    case on = 255           // 打开服务
    
    case acknowledge = 192  // 这个值是自己定义上去的
    
    case new = 128          // 护士站已获取请求，请病人等待
    
    case end = 0            // 结束服务
}

//
//  SHServiceTools + CaChe.swift
//  NurseCall
//
//  Created by Apple on 2019/4/4.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation

// MARK: - 服务缓存的处理
extension SHServiceTools {
    
    /// 添加新服务
    ///
    /// - Parameter service: 服务
    static func createService(_ service: SHService) {
        
        caches.insert(service, at: 0)
    }
    
    
    /// 更新服务的信息
    ///
    /// - Parameter service: 服务
    static func updateService(_ service: SHService) {
        
        for savedService in caches {
            
            if savedService.subNetID == service.subNetID &&
                savedService.deviceID == service.deviceID &&
                savedService.serviceType == service.serviceType {
                
                // 更新状态
                savedService.status = service.status
                
                // 四个时间
                savedService.serviceCallTime =
                    service.serviceCallTime
               
                savedService.serviceAcknowledgeTime =
                    service.serviceAcknowledgeTime
                
                savedService.serviceStartTime = service.serviceStartTime
                
                savedService.serviceFinishedTime = service.serviceFinishedTime
            }
        }
    }
    
    /// 删除已完成的服务
    ///
    /// - Parameter service: 完成的服务
    static func removeService(_ service: SHService) {
        
        let count = caches.count
        
        for index in 0 ..< count {
            
            let savedService = caches[index]
            
            if savedService.subNetID == service.subNetID &&
                savedService.deviceID == service.deviceID &&
                savedService.serviceType == service.serviceType {
                
                caches.remove(at: index)
                break
            }
        }
    }
    
    /// 查询缓存中的服务
    ///
    /// - Parameter service: 服务
    /// - Returns: 存在服务, nil 不存在
    static func selectService(_ service: SHService) -> SHService? {
        
        for savedService in caches {
            
            if savedService.subNetID == service.subNetID &&
                savedService.deviceID == service.deviceID &&
                savedService.serviceType == service.serviceType {
                
                return savedService
            }
        }
        
        return nil
    }
    
}

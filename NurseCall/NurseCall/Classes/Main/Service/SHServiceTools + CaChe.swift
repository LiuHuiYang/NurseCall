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
    
    /// 添加或者更新服务
    ///
    /// - Parameter service: 服务
    static func createOrUpdateService(_ service: SHService) {
        
        let cacheKey = cacheKeyForService(service)
        SHServiceTools.caches.setObject(service, forKey: cacheKey)
    }
    
    /// 删除已完成的服务
    ///
    /// - Parameter service: 完成的服务
    static func removeService(_ service: SHService) {
        
        let cacheKey = cacheKeyForService(service)
        SHServiceTools.caches.removeObject(forKey: cacheKey)
    }
    
    
    /// 查询缓存中的服务
    ///
    /// - Parameter service: 服务
    /// - Returns: 存在服务, nil 不存在
    static func selectService(_ service: SHService) -> SHService? {
        
        let cacheKey = cacheKeyForService(service)
        return
            SHServiceTools.caches.object(forKey: cacheKey)
                as? SHService
    }
    
     
    /// 生成服务在缓存中的key
    ///
    /// - Parameter service: 服务
    /// - Returns: key
    static func cacheKeyForService(_ service: SHService) -> AnyObject {
        
        // 缓存中的key
        return ("\(service.subNetID)-\(service.deviceID)- " +
                "\(service.serviceType.rawValue)")
            as AnyObject
    }
}

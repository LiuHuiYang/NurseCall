//
//  SHSQLiteManager + CallDevice.swift
//  NurseCall
//
//  Created by Apple on 2019/3/21.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation


// MARK: - 更新 呼叫与响应设备
extension SHSQLiteManager {
    
    /// 增加新的设备
    ///
    /// - Parameters:
    ///   - device: 具体设备
    /// - Returns: 增加结构
    func insertDevice(_ device: SHDevice) -> UInt {
        
        let tableName =
            (device.deviceType == .call) ?
                "CALLDEVICES" : "RESPONSEDEVICES"
        
        var name =
            (device.deviceType == .call) ?
                "call device" : "response device"
        
        name = device.remark.isEmpty ? name : device.remark
        
        let sql =
            "insert into \(tableName) " +
                "(deviceType, subNetID, deviceID, remark) " +
                "values(\(device.deviceType.rawValue), " +
                "\(device.subNetID), " +
                "\(device.deviceID),   " +
                "'\(name)');"
        
        if executeSql(sql) {
            
            // 获得当前的id
            let idSQL = "select id from \(tableName);"
            
            guard let maxID = selectProprty(idSQL).last?["id"] as? UInt else {
                
                return 0
            }
            
            return maxID
        }
        
        return 0
    }
    
    /// 更新 呼叫与响应设备
    ///
    /// - Parameters:
    ///   - device: 设备
    /// - Returns: 更新结果
    func updateDevice(_ device: SHDevice) -> Bool {
        
        let tableName =
            (device.deviceType == .call) ?
                "CALLDEVICES" : "RESPONSEDEVICES"
        
        let sql =
            "update \(tableName) set " +
            "subNetID = \(device.subNetID),   " +
            "deviceID = \(device.deviceID),   " +
            "remark = '\(device.remark )' " +
            "where id = \(device.id);"
        
        return executeSql(sql)
    }
    
    /// 删除 对应表格中的设备
    ///
    /// - Parameters:
    ///   - device: 具体的设备
    /// - Returns: true 删除成功 false 删除失败
    func deleteDevices(_ device: SHDevice) -> Bool {
        
        let tableName =
            (device.deviceType == .call) ?
                "CALLDEVICES" : "RESPONSEDEVICES"
        
        let sql =
            "delete from \(tableName) where id = \(device.id);"
        
        return executeSql(sql)
    }
    
    /// 表格中的设备
    ///
    /// - Parameter deviceType: 设备类型
    /// - Returns: 对应的设备
    func getDevices(deviceType: SHDeviceType) -> [SHDevice] {
        
        let tableName =
            (deviceType == .call) ?
                "CALLDEVICES" : "RESPONSEDEVICES"
        
        let sql =
            "select id, deviceType, subNetID, deviceID, remark " +
            "from \(tableName) order by id;"
        
        let array = selectProprty(sql)
        
        var devices = [SHDevice]()
        
        for dict in array {
            
            devices.append(SHDevice(dictionary: dict))
        }
        
        return devices
    }
}






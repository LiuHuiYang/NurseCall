//
//  SHSQLiteManager + CallDevice.swift
//  NurseCall
//
//  Created by Apple on 2019/3/21.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation

extension SHSQLiteManager {
    
    /// 删除 device
    func deleteCallDevice(_ device: SHDevice) -> Bool {
        
        let sql =
            "delete from calldevices " +
            "where id = \(device.id);"
        
        return executeSql(sql)
    }
    
    /// 更新 device
    func updateCallDevice(_ device: SHDevice) -> Bool {
        
        let sql =
            "update calldevices set " +
            "subnetid = '\(device.subNetID )',  " +
            "deviceid = '\(device.deviceID)',   " +
            "remark = '\(device.remark )' " +
            "where id = \(device.id);"
        
        return executeSql(sql)
    }
    
    /// 增加 device
    func insertCallDevice(_ device: SHDevice) -> Bool {
        
        let sql =
            "insert into calldevices " +
                "(devicetype, subnetid, deviceid) " +
                "values(\(device.DeviceType), " +
                "\(device.subNetID),   " +
                "\(device.DeviceType));"
        
        return executeSql(sql)
    }
    
    /// 获取所有的 device
    func getCallDevices() -> [SHDevice] {
        
        let sql =
            "select id, devicetype, subnetid, deviceid, remark " +
            "from calldevices order by id;"
        
        let array = selectProprty(sql)
        
        var devices = [SHDevice]()
        
        for dict in array {
            
            devices.append(SHDevice(dictionary: dict))
        }
        
        return devices
    }
}

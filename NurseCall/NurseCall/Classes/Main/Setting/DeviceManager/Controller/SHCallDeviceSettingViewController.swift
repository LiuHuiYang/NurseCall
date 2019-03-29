//
//  SHCallDeviceSettingViewController.swift
//  NurseCall
//
//  Created by Apple on 2019/3/21.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

/// 设置配置重用标示符
private let deviceSettingCellReuseIdentifier =
    "SHDeviceManagerCell"

class SHCallDeviceSettingViewController: SHViewController {
    
    init(deviceType: SHDeviceManagerType) {
        super.init(nibName: nil, bundle: nil)
        
        self.deviceType = deviceType
        
        self.devices =
            SHSQLiteManager.shared.getCallDevices(
                deviceType: deviceType
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var listView: UICollectionView!
    
    /// 编辑设备
    private var editDevice = false
    
    /// 设备管理类型
    private var deviceType = SHDeviceManagerType.call
    
    /// 所有的呼叫设备
    private lazy var devices = [SHDevice]()
    
   
    /// 添加设备点击
    @IBAction func addDeviceButtonClick() {
        
        let device = SHDevice()
        device.deviceType = self.deviceType
        devices.append(device)
        
        device.id = SHSQLiteManager.shared.insertCallDevice(device)
        
        
        // 添加到数据库中
        if device.id != 0 {
         
            listView.reloadData()
            
            listView.scrollToItem(
                at: IndexPath(item: devices.count - 1, section: 0),
                at: UICollectionView.ScrollPosition.bottom,
                animated: true
            )
        }
    }
    
    
    /// 编辑点击
    @IBAction func editButtonClick() {
        
        if devices.isEmpty {
            return
        }
         
        editDevice = !editDevice
        viewDidLayoutSubviews()
        
        if editDevice {
        
            NotificationCenter.default.post(
                name: Notification.Name(editDeviceStartNotification),
                object: nil
            )
            
        
        } else {
        
            NotificationCenter.default.post(
                name: Notification.Name(editDeviceEndNotification),
                object: nil
            )
        }
    }
}


// MARK: - UICollectionViewDataSource
extension SHCallDeviceSettingViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return devices.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell =
            collectionView.dequeueReusableCell(
                withReuseIdentifier: deviceSettingCellReuseIdentifier,
                for: indexPath
            ) as! SHDeviceManagerCell
        
        cell.device = devices[indexPath.item]
        
        cell.callBack = {
            
            print("执行回调")
            self.devices = SHSQLiteManager.shared.getCallDevices(
                deviceType: self.deviceType
            )
            
            self.listView.reloadData()
            
            // 重新布局
            self.editDevice = false
            self.viewDidLayoutSubviews()
        }
        
        return cell
    }
}


// MARK: - UI初始化
extension SHCallDeviceSettingViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title =
            deviceType == .call ?
                "Call equipment" :
                "Response equipment"
        
        listView.register(UINib(nibName:
            deviceSettingCellReuseIdentifier,
                                bundle: nil),
                          forCellWithReuseIdentifier: deviceSettingCellReuseIdentifier
        )
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let itemMarign: CGFloat = statusBarHeight
        let totalCols = 1
        
        let itemWidth =
            (listView.bounds.width - CGFloat(totalCols) * itemMarign) / CGFloat(totalCols
        )
        
        print("editDevice = \(editDevice)")
        let itemHeight = 7 * tabBarHeight -
            (editDevice ? 0 : tabBarHeight)
        
        let flowLayout =
            listView.collectionViewLayout as!
            UICollectionViewFlowLayout
        
        flowLayout.minimumLineSpacing = itemMarign
        flowLayout.minimumInteritemSpacing = itemMarign
        
        flowLayout.itemSize =
            CGSize(width: itemWidth,
                   height: itemHeight
        )
        
    }
}

//
//  SHDeviceSettingViewController.swift
//  NurseCall
//
//  Created by Apple on 2019/3/21.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class SHDeviceSettingViewController: SHViewController {
    
    /// 显示设备类型
    static var showDeviceType: SHDeviceType = .response
    
    /// 所有的呼叫设备
    private lazy var devices =
        SHSQLiteManager.shared.getDevices(
            deviceType:
            SHDeviceSettingViewController.showDeviceType
    )
    
    /// 编辑设备
    private var editDevice = false
   
    @IBOutlet weak var listView: UICollectionView!
      
   
    /// 添加设备点击
    @IBAction func addDeviceButtonClick() {
        
        let device = SHDevice()
        device.deviceType = SHDeviceSettingViewController.showDeviceType
        device.id = SHSQLiteManager.shared.insertDevice(device)
        
        devices =
            SHSQLiteManager.shared.getDevices(deviceType:
                SHDeviceSettingViewController.showDeviceType
        )
        
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
extension SHDeviceSettingViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return devices.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell =
            collectionView.dequeueReusableCell(
                withReuseIdentifier: deviceSettingCellReuseIdentifier,
                for: indexPath
            ) as! SHDeviceManagerCell
        
        
        let device = devices[indexPath.item]
        
        
        cell.device = devices[indexPath.item]
        
        cell.callBack = {
        
            self.devices =
                SHSQLiteManager.shared.getDevices(deviceType:
                    SHDeviceSettingViewController.showDeviceType
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
extension SHDeviceSettingViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title =
            SHDeviceSettingViewController.showDeviceType == .call ? "Call Equipment" : "Response Equipment"
        
        
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
        
        let itemHeight = SHDeviceManagerCell.itemHeight -
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

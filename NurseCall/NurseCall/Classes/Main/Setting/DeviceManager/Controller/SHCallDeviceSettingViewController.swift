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

    @IBOutlet weak var listView: UICollectionView!
    
    /// 所有的呼叫设备
    private lazy var devices: [SHDevice] =
        SHSQLiteManager.shared.getCallDevices()
    
   
    /// 添加设备点击
    @IBAction func addDeviceButtonClick() {
        
        let device = SHDevice()
        devices.append(device)
        
        device.id = SHSQLiteManager.shared.insertCallDevice(device)
        
        // 添加到数据库中
        if device.id != 0 {
         
            listView.reloadData()
            
//            listView.scrollToItem(
//                at: IndexPath(item: devices.count, section: 0),
//                at: UICollectionView.ScrollPosition.bottom,
//                animated: true
//            )
            
            
        }
    }
    
    
    /// 编辑点击
    @IBAction func editButtonClick() {
        
        if devices.isEmpty {
            return
        }
        
        NotificationCenter.default.post(
            name: Notification.Name(editDeviceNotification),
            object: nil
        )
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
            self.devices = SHSQLiteManager.shared.getCallDevices()
            self.listView.reloadData()
        }
        
        return cell
    }
}


// MARK: - UI初始化
extension SHCallDeviceSettingViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Call equipment"
        
        listView.register(UINib(nibName:
            deviceSettingCellReuseIdentifier,
                                bundle: nil),
                          forCellWithReuseIdentifier: deviceSettingCellReuseIdentifier
        )
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let itemMarign: CGFloat = 1
        let totalCols = 1
        
        let itemWidth = (listView.bounds.width - CGFloat(totalCols) * itemMarign) / CGFloat(totalCols)
        
        let flowLayout = listView.collectionViewLayout as! UICollectionViewFlowLayout
        
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        
        flowLayout.minimumLineSpacing = itemMarign
        flowLayout.minimumInteritemSpacing = itemMarign
    }
}

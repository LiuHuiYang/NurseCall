//
//  SHSickRoomViewController.swift
//  NurseCall
//
//  Created by Apple on 2019/3/29.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

/// 设置配置重用标示符
private let nurseStationCellReuseIdentifier =
    "SHNurseStationCollectionCell"

class SHNurseStationViewController: SHViewController {
    
    /// 所有的护士站
    private lazy var nurseStations = [SHNurseStation]()
    
    /// 编辑设备
    private var editDevice = false
    
    /// 列表
    @IBOutlet weak var listView: UICollectionView!
    
    /// 设置按钮
    @IBOutlet weak var settingButton: UIButton!
    
    
    /// 设置View
    @IBOutlet weak var settingView: UIView!
    
    
   

    /// 添加设备点击
    @IBAction func addSickRoomButtonClick() {
        
//        let device = SHDevice()
//        device.deviceType = self.deviceType
//        device.id = SHSQLiteManager.shared.insertCallDevice(device)
//
//
//        // 添加到数据库中
//        if device.id != 0 {
//
//            self.devices =
//                SHSQLiteManager.shared.getCallDevices(
//                    deviceType: self.deviceType
//            )
//
//            listView.reloadData()
//
//            listView.scrollToItem(
//                at: IndexPath(item: devices.count - 1, section: 0),
//                at: UICollectionView.ScrollPosition.bottom,
//                animated: true
//            )
//        }
    }
    
    
    /// 编辑点击
    @IBAction func editSickRoomClick() {
        
        if nurseStations.isEmpty {
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

    /// 设置按钮点击
    @IBAction func settingButtonClick() {
        
        UIView.animate(withDuration: 1.0) {
            
            self.settingButton.isSelected =
                !self.settingButton.isSelected
            
            self.settingView.isHidden = !self.settingView.isHidden
            
        
            if self.settingButton.isSelected == false &&
                self.editDevice {
                
                NotificationCenter.default.post(
                    name: Notification.Name(editDeviceEndNotification),
                    object: nil
                )
                
            }
            
        }
    }
    
}

// MARK: - UICollectionViewDataSource
extension SHNurseStationViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return nurseStations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell =
            collectionView.dequeueReusableCell(
                withReuseIdentifier: nurseStationCellReuseIdentifier,
                for: indexPath
                ) as! SHNurseStationCollectionCell
        
//        cell.sickRoom = sickRooms[indexPath.item]
        
        cell.callBack = {

//            self.devices =
//                SHSQLiteManager.shared.getCallDevices(
//                    deviceType: self.deviceType
//            )

            self.listView.reloadData()

            // 重新布局
            self.editDevice = false
            self.viewDidLayoutSubviews()
        }
        
        return cell
    }
}


// MARK: - UI初始化
extension SHNurseStationViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in 1 ... 5 {
            
            let station = SHNurseStation()
            nurseStations.append(station)
        }
        
        settingView.isHidden = true
        
        listView.register(UINib(nibName:
            nurseStationCellReuseIdentifier,
                                bundle: nil),
                          forCellWithReuseIdentifier: nurseStationCellReuseIdentifier
        )
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let itemMarign: CGFloat = statusBarHeight
        let totalCols = 1
        
        let itemWidth =
            (listView.bounds.width - CGFloat(totalCols) * itemMarign) / CGFloat(totalCols
        )
        
        let itemHeight =
            SHNurseStationCollectionCell.itemHeight -
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

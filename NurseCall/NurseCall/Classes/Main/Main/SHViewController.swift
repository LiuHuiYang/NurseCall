//
//  SHViewController.swift
//  NurseCall
//
//  Created by Apple on 2019/3/15.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class SHViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
 
       view.backgroundColor = UIColor(white: 241.0/255.0, alpha: 1.0)
        
       // 接收socket
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.receiveBroadcastMessages(_:)
            ),
            name: NSNotification.Name(rawValue: SHSocketTools.broadcastNotificationName), object: nil
        )
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    
    /// 接收到广播消息
    ///
    /// - Parameter notification: 通知消息
    @objc func receiveBroadcastMessages(_ notification: Notification) {
       
         guard let socketData =
            notification.userInfo?[SHSocketTools.broadcastNotificationName] as? SHSocketData else {
                
                return
        }
        
        // 不是呼叫报务不工作
        if socketData.operatorCode != 0x03B2 &&
            socketData.operatorCode != 0x03B3 {
            return
        }
        
        
        
        
        
        print(socketData)
        
    }
}


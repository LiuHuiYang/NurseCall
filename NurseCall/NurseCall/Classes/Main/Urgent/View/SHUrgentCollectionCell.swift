//
//  SHUrgentCollectionCell.swift
//  NurseCall
//
//  Created by Apple on 2019/4/4.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import TYAlertController

/// 普通呼叫的颜色
private let generalColor = UIColor.color(colorHex: 0x3198f2)

/// 紧急呼品性的颜色 
private let emergencyeColor = UIColor.color(colorHex: 0xEE4444)

class SHUrgentCollectionCell: UICollectionViewCell {
    
    var service: SHService? {
        
        didSet {
            
            nameLabel.text = service?.serviceName
            
            let isNormalLevel =
                service?.serviceLevel == SHServiceLevel.normal
            
            levelIconView.backgroundColor =
                isNormalLevel ? generalColor : emergencyeColor
            
            levelLabel.text = isNormalLevel ? "LOW" : "HIGH"
            
//            timeLabel.text = "\(service?.currentTime ?? "")"
        }
    }
    
    
    /// 服务名称
    @IBOutlet weak var nameLabel: UILabel!
    
    
    /// 等级图标
    @IBOutlet weak var levelIconView: UIImageView!
    
    /// 等级文字
    @IBOutlet weak var levelLabel: UILabel!
    
    /// 时间
    @IBOutlet weak var timeLabel: UILabel!
    
    /// item高度
    static var itemHeight: CGFloat {
        
        return navigationBarHeight * 2
    }

    override func awakeFromNib() {
        super.awakeFromNib()
       
        // 增加一个长按手势
        let longPress =
            UILongPressGestureRecognizer(
                target: self,
                action: #selector(longPressService(_:)
                )
        )
        
        longPress.minimumPressDuration = 1.5
        
        addGestureRecognizer(longPress)
    }
}

extension SHUrgentCollectionCell {
    
    
    /// 长按处理响应
    ///
    /// - Parameter recognizer: 响应手势
    @objc private func longPressService(
        _ recognizer: UILongPressGestureRecognizer) {
        
        if recognizer.state != .began {
            return
        }
        
        // FIXME: -
        // 针对当前的 service 进行选择, 发送操作指令.
        
        let alertView =
            TYCustomAlertView.setupAlertView(
                "",
                message: "",
                isCustom: true
        )
        
        // 开启服务
        let startAction = TYAlertAction(title: "Start", style: .cancel) { (action) in
            
        }
        
        
        // 结束服务
        let finishAction = TYAlertAction(title: "Finished", style: .cancel) { (action) in
            
        }
        
        
        // 响应服务
        let acknowledgeAction = TYAlertAction(title: "Acknowledge", style: .default) { (action) in
            
        }
        
        // 紧急服务
        let codeBlueAction = TYAlertAction(title: "Code Blue", style: .destructive) { (action) in
            
        }
        
        alertView.add(startAction)
        alertView.add(finishAction)
        alertView.add(acknowledgeAction)
        alertView.add(codeBlueAction)
        
        let alertController =
            TYAlertController(alert: alertView,
                              preferredStyle: .alert,
                              transitionAnimation: .scaleFade
            )!
        
        alertController.backgoundTapDismissEnable = true
        
        UIApplication.shared.keyWindow?.rootViewController?.present(
            alertController,
            animated: true,
            completion: nil
        )
    }
}

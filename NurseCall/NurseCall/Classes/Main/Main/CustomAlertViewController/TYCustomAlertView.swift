//
//  TYCustomAlertView.swift
//  NurseCall
//
//  Created by Apple on 2019/3/21.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import TYAlertController

class TYCustomAlertView: TYAlertView {

}

extension TYCustomAlertView {
    
    static func setupAlertView(_ title: String, message: String, isCustom: Bool) -> TYCustomAlertView {
        
        
        if isCustom == false {
            
            return TYCustomAlertView(title: title, message: message)
        }
        
        guard let customView = TYCustomAlertView(title: "", message: "") else {
            
            return TYCustomAlertView(title: title, message: message)
        }
        
        customView.layer.cornerRadius =
            UIDevice.is_iPad() ? statusBarHeight :
            statusBarHeight * 0.5

        customView.clipsToBounds = true

        customView.backgroundColor =
            UIColor.color(colorHex: 0xddFbFb, alpha: 0.85)

        let alertWidth =
            CGFloat.minimum(UIView.frame_screenWidth(),
                            UIView.frame_screenHeight()
                ) * 0.65

        customView.alertViewWidth =
            alertWidth > 280 ? alertWidth : 280

        customView.contentViewSpace = statusBarHeight

        // =============  提示文字 ======================

        if title.isEmpty == false {

            customView.textLabelSpace = statusBarHeight

            let font =
                UIFont(name: "HelveticaNeue",
                       size: (UIDevice.is_iPad() ? 30 : 20)
            )

            let titleTextAttributes = [
                NSAttributedString.Key.font: font,

                NSAttributedString.Key.foregroundColor:
                    UIColor.darkGray
            ]

            let attributedMessage =
                NSAttributedString(string: title,
                                   attributes: titleTextAttributes as [NSAttributedString.Key : Any])

            customView.messageLabel.attributedText = attributedMessage
            customView.messageLabel.numberOfLines = 0;
        }

        if message.isEmpty == false {

            customView.textLabelContentViewEdge = statusBarHeight

            let font =
                UIFont(name: "HelveticaNeue",
                       size: (UIDevice.is_iPad() ? 22 : 13)
            )

            let titleTextAttributes = [
                NSAttributedString.Key.font: font,

                NSAttributedString.Key.foregroundColor:
                    UIColor.darkGray
            ]

            let attributedMessage =
                NSAttributedString(string: title,
                                   attributes: titleTextAttributes as [NSAttributedString.Key : Any])

            customView.messageLabel.attributedText = attributedMessage
            customView.messageLabel.numberOfLines = 0;
        }

        let font =
            UIDevice.is_iPad() ?
                UIFont.boldSystemFont(ofSize: 28) :
                UIFont.boldSystemFont(ofSize: 16)


        let height =
            UIDevice.is_iPad() ?
                navigationBarHeight + statusBarHeight :
        tabBarHeight

        // =============  中间的按钮 ======================

        customView.buttonSpace = statusBarHeight

        customView.buttonHeight = height

        customView.buttonCornerRadius = statusBarHeight * 0.5

        customView.buttonFont = font


        // =============  textField ======================
        customView.textFieldFont = font

        customView.textFieldHeight = height
        
        return customView
     
    }
}


 
import UIKit

 extension UIColor {
    
    
    /// 生成颜色
    ///
    /// - Parameters:
    ///   - redColor: 红色
    ///   - greenColor: 绿色
    ///   - blueColor: 蓝色
    ///   - alpha: 透明度
    /// - Returns: UIColor
    static func color(redColor: UInt8, greenColor: UInt8, blueColor: UInt8, alpha: CGFloat = 1.0) -> UIColor {
        
        return UIColor(red: CGFloat(redColor) / 255.0,
                green: CGFloat(greenColor) / 255.0,
                blue: CGFloat(blueColor) / 255.0,
                alpha: alpha
        )
    }
    
    
    /// 随机颜色
    ///
    /// - Parameter alpha: 透明度 【默认1.0】
    /// - Returns: UIColor
    static func randomColor(_ alpha: CGFloat = 1.0) -> UIColor {
     
        return UIColor(red: CGFloat.random(in: 0 ... 1.0),
                       green: CGFloat.random(in: 0 ... 1.0),
                       blue: CGFloat.random(in: 0 ... 1.0),
                       alpha: alpha
        )
    }
    
    
    /// 依据RGB值直接设置颜色
    ///
    /// - Parameters:
    ///   - colorHex: 颜色的十六进制表示(必须是0x开头)
    ///   - alpha: 透明度度[0,1]
    /// - Returns: UIColor
    static func color(colorHex: UInt32, alpha: CGFloat = 1.0) -> UIColor {
 
        // 获得各种颜色 255 255 255 ==  #0x ff ff ff
        let red = UInt8((colorHex & 0xff0000) >> 16)
        let green = UInt8((colorHex & 0x00ff00) >> 8)
        let blue = UInt8(colorHex & 0x0000ff)
  
        return UIColor.color(redColor: red,
                             greenColor: green,
                             blueColor: blue,
                             alpha: alpha
        )
    }
    
 }

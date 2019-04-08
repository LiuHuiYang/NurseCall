 
import Foundation

 
// MARK: - 日期工具类
extension Date {
    
    
    /// 当地时间
    ///
    /// - Returns: Date
    static func localTime() -> Date {
        
        let date = Date() // GMT时间
        
        // 当前时区与GMT相差时间
        let interval:NSInteger =
            NSTimeZone.local.secondsFromGMT(for: date)
        
        // 当地时间
        let now = date.addingTimeInterval(
            TimeInterval(interval)
        )
        
        return now
    }
}

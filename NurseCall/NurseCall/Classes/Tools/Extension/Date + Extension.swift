 
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
 

 
// MARK: - 时间与字符串的转换
extension Date {
 
    /// 时间转换为 字符串
    ///
    /// - Parameters:
    ///   - date: GMT时间 默认为当前时间 (注意这个参数)
    ///   - formatter: 字符串格式 如:yyyy-MM-dd  HH:mm:ss
    /// - Returns: 时间字符串
    static func dateToString(_ date: Date = Date(), formatter: String) -> String {
        
        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = NSTimeZone.local
        dateFormatter.dateFormat = formatter
        
        return dateFormatter.string(from: date)
    }
    

    /// 字符串转换为 Date
    ///
    /// - Parameters:
    ///   - string: 时间或日期的字符串
    ///   - formatter: 格式化字符串
    /// - Returns: Date 转换失败则返回当前GMT时间
    static func stringToDate(_ string: String, formatter: String) -> Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = formatter
        
        return dateFormatter.date(from: string) ?? Date()
    }
}

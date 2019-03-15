

import Foundation

extension Bundle {
    
    static var namespace: String {
        
        return Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""
    }
}

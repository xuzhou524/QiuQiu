//
//  XZGameDecorateConfig.swift
//  QiuQiu
//
//  Created by xuzhou on 2021/3/16.
//

import UIKit
import SwiftyStoreKit

class XZGameDecorateConfig: NSObject {
    
    static let shared = XZGameDecorateConfig()
    
    /// Game配置
    //主题图案
    var gameThemeChineseZodiacType: Int = 1
    
    @objc static func getGameThemeChineseZodiacType() -> Int {
        return XZGameDecorateConfig.shared.gameThemeChineseZodiacType
    }
    
    @objc static func restorePurchases() -> Bool {
        var isRestore = false
        let receipt = AppleReceiptValidator(service: .production)
        SwiftyStoreKit.verifyReceipt(using: receipt) { (result) in
            switch result {
            case .success(let receipt):
             print("receipt--->\(receipt)")
                isRestore = true
                break
            case .error(let error):
                print("error--->\(error)")
                break
            }
        }
        return isRestore
    }

}

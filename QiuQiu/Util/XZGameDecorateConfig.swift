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
        let receipt = AppleReceiptValidator(service: .production)
        return restorePurchaseCheck(validator: receipt)
    }
    
    static func restorePurchaseCheck(validator: ReceiptValidator) -> Bool {
        var isRestore = false
        SwiftyStoreKit.verifyReceipt(using: validator) { (result) in
            switch result {
            case .success(let receipt):
             print("receipt--->\(receipt)")
                let status: Int = receipt["status"] as! Int
                if status == 0 {
                    let appReceipt = receipt["receipt"] as? ReceiptInfo
                    let inApp = appReceipt?["in_app"] as? [ReceiptInfo]
                    if inApp?.count ?? 0 > 0 {
                        isRestore = true
                    }
                }else if status == 21007 {
                    restorePurchaseCheck(validator: AppleReceiptValidator(service: .sandbox))
                }
                break
            case .error(let error):
                print("error--->\(error)")
                break
            }
        }
        return isRestore
    }

}

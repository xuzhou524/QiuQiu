//
//  XZGameDecorateConfig.swift
//  QiuQiu
//
//  Created by xuzhou on 2021/3/16.
//

import UIKit

class XZGameDecorateConfig: NSObject {
    
    static let shared = XZGameDecorateConfig()
    
    /// Game配置
    //主题图案
    var gameThemeChineseZodiacType: Int = 1
    
    @objc static func getGameThemeChineseZodiacType() -> Int {
        return XZGameDecorateConfig.shared.gameThemeChineseZodiacType
    }

}

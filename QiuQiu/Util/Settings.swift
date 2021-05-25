//
//  Settings.swift
//  YoYoPinXiaoLe
//
//  Created by xuzhou on 2021/4/25.
//

import UIKit
import DefaultsKit

enum XZSettingKey:String {
    ///是否开启音效开关
    case kSoundSwitch = "YoYoPinXiaoLe.soundSwitch"
    ///是否显示过帮助中心
    case kHelpPop = "YoYoPinXiaoLe.helpPop"
    
}

class XZSettings{
    static let shared = XZSettings()
    private init(){
        
    }
    
    subscript(key:String) -> String? {
        get {
            let storeKey = Key<String>(key)
            return Defaults.shared.get(for: storeKey)
        }
        set {
            let storeKey = Key<String>(key)
            if let value = newValue {
                Defaults.shared.set(value, for: storeKey)
            }
            else {
                Defaults.shared.clear(storeKey)
            }
        }
    }
    
    subscript(key:XZSettingKey) -> String? {
        get {
            return self[key.rawValue]
        }
        set {
            self[key.rawValue] = newValue
        }
    }
    
    subscript<T : Codable>(key:String) -> T? {
        get {
            let storeKey = Key<T>(key)
            return Defaults.shared.get(for: storeKey)
        }
        set {
            let storeKey = Key<T>(key)
            if let value = newValue {
                Defaults.shared.set(value, for: storeKey)
            }
            else {
                Defaults.shared.clear(storeKey)
            }
        }
    }
    subscript<T : Codable>(key:XZSettingKey) -> T? {
        get {
            return self[key.rawValue]
        }
        set {
            self[key.rawValue] = newValue
        }
    }
}

let Settings = XZSettings.shared


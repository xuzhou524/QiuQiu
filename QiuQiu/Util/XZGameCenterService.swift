//
//  XZGameCenterService.swift
//  QiuQiu
//
//  Created by gozap on 2021/4/19.
//

import UIKit
import GameKit
import GameplayKit

class XZGameCenterService: NSObject {
    static let shared = XZGameCenterService()
    
    @objc static func saveHighScore(score:NSInteger){
        if GKLocalPlayer.local.isAuthenticated {
            let scoreReporter = GKScore(leaderboardIdentifier: "XZGame_ChineseZodiac")
            scoreReporter.value = Int64(score)
            GKScore.report([scoreReporter], withCompletionHandler: nil)
        }
    }
    
}

//
//  PlayBubbleViewController.swift
//  QiuQiu
//
//  Created by xuzhou on 2021/4/12.
//

import UIKit

class PlayBubbleViewController: UIViewController,TCAMySceneDelegate {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let skView : SKView = SKView.init(frame: UIScreen.main.bounds)
        skView.ignoresSiblingOrder = true;
        self.view.addSubview(skView)

        let ga = XZGameScene.init(size: UIScreen.main.bounds.size)
        ga.scaleMode = .aspectFill
        ga.delegate = self

        skView.presentScene(ga)
    }
    
    func mySceneDidFinish(_ gameScene: XZGameScene!) {
        self.navigationController?.popToRootViewController(animated: true)
    }

}

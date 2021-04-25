//
//  HelpViewController.swift
//  QiuQiu
//
//  Created by xuzhou on 2021/4/12.
//

import UIKit

class HelpViewController: UIViewController {

    let withoutView:WithoutAuthorizationView = {
        let view = WithoutAuthorizationView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "帮助中心"
        self.view.backgroundColor = UIColor(named: "color_theme")

        self.view.addSubview(withoutView)
        withoutView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(self.view)
        }
        
    }
}

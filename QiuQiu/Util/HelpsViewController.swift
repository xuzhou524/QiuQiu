//
//  HelpsViewController.swift
//  YoYoPinXiaoLe
//
//  Created by gozap on 2021/5/25.
//

import UIKit

class HelpsViewController: UIViewController {

    let withoutView:WithoutAuthorizationsView = {
        let view = WithoutAuthorizationsView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(named: "color_theme")

        self.view.addSubview(withoutView)
        withoutView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(self.view)
        }
        
    }

}

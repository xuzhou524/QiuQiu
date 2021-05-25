//
//  WithoutAuthorizationsView.swift
//  YoYoPinXiaoLe
//
//  Created by gozap on 2021/5/25.
//

import UIKit

class WithoutAuthorizationsView: UIView {

    let titleLabel:UILabel = {
        let label = UILabel()
        label.font = blodFontWithSize(18)
        label.textColor = UIColor(named: "color_title_black")
        label.text = "帮助中心"
        return label
    }()
    
    let oneLabel:UILabel = {
        let label = UILabel()
        label.font = blodFontWithSize(13)
        label.textColor = UIColor(named: "color_title_black")
        label.numberOfLines = 0
        label.text = "第一步：打开iPhone手机系统设置，找到Game Center功能。"
        return label
    }()
    
    let oneImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "helpOne")
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let twoLabel:UILabel = {
        let label = UILabel()
        label.font = blodFontWithSize(13)
        label.textColor = UIColor(named: "color_title_black")
        label.numberOfLines = 0
        label.text = "第二步：点击Game Center，打开授权开关并登录Apple Id账号。"
        return label
    }()
    
    let twoImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "helpTwe")
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let threeLabel:UILabel = {
        let label = UILabel()
        label.font = blodFontWithSize(13)
        label.textColor = UIColor(named: "color_title_black")
        label.numberOfLines = 0
        label.text = "第三步：登录完成之后，请退出”生肖来了“APP后台重新打开”生肖来了“APP挑战您的排行。"
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(named: "color_theme")
        sebViews()
    }
    
    func sebViews() {
        
        self.addSubview(titleLabel)
        
        self.addSubview(oneLabel)
        self.addSubview(oneImageView)
        self.addSubview(twoLabel)
        self.addSubview(twoImageView)
        self.addSubview(threeLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
        }
        
        oneLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
        
        oneImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalTo(oneLabel.snp.bottom).offset(10)
            make.height.equalTo((kScreenWidth - 50) / 2.36)
        }
        
        twoLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalTo(oneImageView.snp.bottom).offset(15)
        }
        
        twoImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalTo(twoLabel.snp.bottom).offset(10)
            make.height.equalTo((kScreenWidth - 50) / 1.47)
        }
        
        threeLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalTo(twoImageView.snp.bottom).offset(15)
        }
        
    }

}

//
//  HomeCardView.swift
//  QiuQiu
//
//  Created by xuzhou on 2021/4/16.
//

import UIKit

class HomeCardView: UIView {
    
    let bgImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_QiuQiu")
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.font = blodFontWithSize(22)
        label.textColor = UIColor(named: "color_white")
        label.text = "生肖来了"
        return label
    }()
    
    let summeryLabel:UILabel = {
        let label = UILabel()
        label.font = blodFontWithSize(13)
        label.textColor = UIColor(named: "color_white")
        label.text = "简单又好玩的解压神器"
        return label
    }()
    
    let rulesLabel:UILabel = {
        let label = UILabel()
        label.font = blodFontWithSize(12)
        label.alpha = 0.8
        label.numberOfLines = 0
        label.textColor = UIColor(named: "color_white")
        label.text = "规则：点击每一个生肖，遗漏一个则结束游戏，点击💣也会结束游戏"
        return label
    }()
    
    let starImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_starThree")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor(named: "color_white")
        return imageView
    }()
    
    let tipButton:UIButton = {
        let button = UIButton()
        button.setTitle("开始挑战", for: .normal)
        button.setTitleColor(UIColor(named: "color_black"), for: .normal)
        button.titleLabel?.font = blodFontWithSize(18)
        button.setBackgroundImage(UIColor(named: "color_white")?.image, for: .normal)
        button.layer.cornerRadius = 19
        button.layer.masksToBounds = true
        return button
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        sebViews()
    }
    
    func sebViews() {
        
        self.addSubview(bgImageView)
        self.addSubview(titleLabel)
        self.addSubview(summeryLabel)
        self.addSubview(rulesLabel)
        self.addSubview(tipButton)
        self.addSubview(starImageView)
        
        bgImageView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(15)
            make.bottom.right.equalToSuperview().offset(-15)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(35)
            make.top.equalToSuperview().offset(35)
        }
        
        summeryLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        
        rulesLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.right.equalToSuperview().offset(-35)
            make.bottom.equalToSuperview().offset(-30)
        }
        
        tipButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-35)
            make.bottom.equalTo(rulesLabel.snp.top).offset(-15)
            make.height.equalTo(38)
            make.width.equalTo(110)
        }
        
        starImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(titleLabel)
            make.right.equalToSuperview().offset(-35)
            make.width.equalTo(50)
            make.height.equalTo(15.4)
        }
    }
}

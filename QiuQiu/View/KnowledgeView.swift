//
//  KnowledgeView.swift
//  QiuQiu
//
//  Created by gozap on 2021/4/21.
//

import UIKit

class KnowledgeView: UIView {

    let titleLabel:UILabel = {
        let label = UILabel()
        label.font = blodFontWithSize(22)
        label.textColor = UIColor(named: "color_black")
        label.text = "鼠"
        return label
    }()
    
    let summeryLabel:UILabel = {
        let label = UILabel()
        label.font = fontWithSize(13)
        label.textColor = UIColor(named: "color_black")
        label.text = "简单又好玩的解压神器"
        label.numberOfLines = 0
        return label
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.orange
        return imageView;
    }()
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(named: "color_white")
        sebViews()
    }
    
    func sebViews() {
        
        self.addSubview(titleLabel)
        self.addSubview(summeryLabel)
//        self.addSubview(iconImageView)

        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(25)
        }
        
        summeryLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.right.equalToSuperview().offset(-15)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
        
//        iconImageView.snp.makeConstraints { (make) in
//            make.centerX.equalToSuperview()
//            make.bottom.equalToSuperview().offset(-25)
//            make.width.height.equalTo(200)
//        }
        
    }

}

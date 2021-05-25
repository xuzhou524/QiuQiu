//
//  LeftTitleTableViewCell.swift
//  QiuQiu
//
//  Created by xuzhou on 2021/4/16.
//

import UIKit

class LeftTitleTableViewCell: UITableViewCell {
    
    var nodeImageView: UIImageView = UIImageView()
    var rightImageView: UIImageView = UIImageView()
    var nodeNameLabel: UILabel = {
        let label =  UILabel()
        label.font = fontWithSize(15)
        label.textColor = UIColor(named: "color_black")
        return label
    }()
    var summeryLabel: UILabel = {
        let label =  UILabel()
        label.font = fontWithSize(15)
        label.textColor = UIColor(named: "color_black")
        return label
    }()
    
    var panel: UIView = {
        let view =  UIView()
        view.backgroundColor = UIColor(named: "color_white")
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.setup();
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup()->Void{
        self.selectionStyle = .none
        self.backgroundColor = UIColor(named: "color_theme")
        
        self.contentView.addSubview(panel)
        panel.addSubview(self.nodeImageView)
        panel.addSubview(self.nodeNameLabel)
        panel.addSubview(self.rightImageView)
        panel.addSubview(self.summeryLabel)
        
        panel.snp.makeConstraints{ (make) -> Void in
            make.left.equalTo(self.contentView).offset(15)
            make.right.equalTo(self.contentView).offset(-15)
            make.bottom.top.equalTo(self.contentView)
        }
        self.nodeImageView.tintColor = UIColor(named: "color_black")
        self.nodeImageView.snp.makeConstraints{ (make) -> Void in
            make.centerY.equalTo(panel)
            make.left.equalTo(panel).offset(15)
            make.width.height.equalTo(22)
        }
        
        self.nodeNameLabel.snp.makeConstraints{ (make) -> Void in
            make.left.equalTo(self.nodeImageView.snp.right).offset(15)
            make.centerY.equalTo(self.nodeImageView)
        }
        self.rightImageView.image = UIImage(named: "circleright")
        self.rightImageView.tintColor = UIColor(named: "color_black")
        self.rightImageView.snp.makeConstraints{ (make) -> Void in
            make.centerY.equalTo(panel)
            make.right.equalTo(panel).offset(-15)
            make.width.equalTo(8)
            make.height.equalTo(12)
        }
        self.summeryLabel.snp.remakeConstraints { (make) in
            make.right.equalTo(self.rightImageView.snp.left).offset(-5)
            make.centerY.equalTo(self.nodeImageView)
        }
        
        self.summeryLabel.isHidden = true
        
    }
    
    func isHiddenRightImage(hidden:Bool){
        if hidden {
            self.rightImageView.snp.makeConstraints{ (make) -> Void in
                make.centerY.equalTo(panel)
                make.right.equalTo(panel).offset(-10)
                make.width.height.equalTo(0)
            }
        }else{
            self.rightImageView.snp.makeConstraints{ (make) -> Void in
                make.centerY.equalTo(panel)
                make.right.equalTo(panel).offset(-15)
                make.width.height.equalTo(25)
            }
        }
    }
}


class LeftTitleBuyTableViewCell: UITableViewCell {
    
    var nodeImageView: UIImageView = UIImageView()
    var rightImageView: UIImageView = UIImageView()
    var vipBtn: UIButton = UIButton()
    var nodeNameLabel: UILabel = {
        let label =  UILabel()
        label.font = fontWithSize(15)
        label.textColor = UIColor(named: "color_black")
        return label
    }()
    var summeryLabel: UILabel = {
        let label =  UILabel()
        label.font = fontWithSize(15)
        label.textColor = UIColor(named: "color_black")
        return label
    }()
    
    var panel: UIView = {
        let view =  UIView()
        view.backgroundColor = UIColor(named: "color_white")
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.setup();
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup()->Void{
        self.selectionStyle = .none
        self.backgroundColor = UIColor(named: "color_theme")
        
        self.contentView.addSubview(panel)
        panel.addSubview(self.nodeImageView)
        panel.addSubview(self.nodeNameLabel)
        panel.addSubview(self.vipBtn)
        panel.addSubview(self.rightImageView)
        panel.addSubview(self.summeryLabel)
        
        panel.snp.makeConstraints{ (make) -> Void in
            make.left.equalTo(self.contentView).offset(15)
            make.right.equalTo(self.contentView).offset(-15)
            make.bottom.top.equalTo(self.contentView)
        }
        self.nodeImageView.tintColor = UIColor(named: "color_black")
        self.nodeImageView.snp.makeConstraints{ (make) -> Void in
            make.centerY.equalTo(panel)
            make.left.equalTo(panel).offset(15)
            make.width.height.equalTo(22)
        }
        
        self.nodeNameLabel.snp.makeConstraints{ (make) -> Void in
            make.left.equalTo(self.nodeImageView.snp.right).offset(15)
            make.centerY.equalTo(self.nodeImageView)
        }
        
        self.vipBtn.backgroundColor = UIColor(named: "color_black")
        self.vipBtn.setTitle("购买", for: .normal)
        self.vipBtn.titleLabel?.font = fontWithSize(13)
        self.vipBtn.setTitleColor(UIColor.white, for: .normal)
        self.vipBtn.layer.cornerRadius = 12
        self.vipBtn.layer.masksToBounds = true
        self.vipBtn.snp.makeConstraints{ (make) -> Void in
            make.centerY.equalTo(panel)
            make.right.equalTo(panel).offset(-30)
            make.width.equalTo(60)
            make.height.equalTo(24)
        }
        
        self.rightImageView.image = UIImage(named: "circleright")
        self.rightImageView.tintColor = UIColor(named: "color_black")
        self.rightImageView.snp.makeConstraints{ (make) -> Void in
            make.centerY.equalTo(panel)
            make.right.equalTo(panel).offset(-15)
            make.width.equalTo(8)
            make.height.equalTo(12)
        }
        self.summeryLabel.snp.remakeConstraints { (make) in
            make.right.equalTo(self.rightImageView.snp.left).offset(-5)
            make.centerY.equalTo(self.nodeImageView)
        }
        
        self.summeryLabel.isHidden = true
        
    }
    
    func isHiddenRightImage(hidden:Bool){
        if hidden {
            self.rightImageView.snp.makeConstraints{ (make) -> Void in
                make.centerY.equalTo(panel)
                make.right.equalTo(panel).offset(-10)
                make.width.height.equalTo(0)
            }
        }else{
            self.rightImageView.snp.makeConstraints{ (make) -> Void in
                make.centerY.equalTo(panel)
                make.right.equalTo(panel).offset(-15)
                make.width.height.equalTo(25)
            }
        }
    }
}

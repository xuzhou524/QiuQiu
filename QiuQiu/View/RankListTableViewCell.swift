//
//  RankListTableViewCell.swift
//  QiuQiu
//
//  Created by xuzhou on 2021/4/16.
//

import UIKit

class RankListTableViewCell: UITableViewCell {
    
    let iconImageView:UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let rankLabel:UILabel = {
        let label = UILabel()
        label.font = blodFontWithSize(18)
        label.textColor = UIColor(named: "color_title_black")
        label.text = "1"
        return label
    }()

    let titleLabel:UILabel = {
        let label = UILabel()
        label.font = fontWithSize(15)
        label.textColor = UIColor(named: "color_title_black")
        label.text = "哈哈"
        return label
    }()

    let scoreLabel:UILabel = {
        let label = UILabel()
        label.font = fontWithSize(15)
        label.textColor = UIColor(named: "color_title_black")
        label.text = "23,521"
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.clipsToBounds = true
        self.selectionStyle = .none;
        self.contentView.backgroundColor = UIColor(named: "color_theme")
        sebViews()
    }
    
    func sebViews() {

        self.contentView.addSubview(iconImageView)
        self.contentView.addSubview(rankLabel)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(scoreLabel)
        
        iconImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(25)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(30)
        }
        
        rankLabel.snp.makeConstraints { (make) in
            make.center.equalTo(iconImageView)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconImageView.snp.right).offset(15)
            make.centerY.equalToSuperview()
        }

        scoreLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-28)
            make.centerY.equalToSuperview()
        }
    }
}

class RankHeadView: UIView {
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.font = blodFontWithSize(20)
        label.textColor = UIColor(named: "color_title_black")
        label.text = "全球排行榜"
        return label
    }()
    
    let tipView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    let iconImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "circleright")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor(named: "color_title_black")
        return imageView
    }()
    
    let bgView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "color_title_black")
        view.alpha = 0.2
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        return view
    }()
    
    let rankLabel:UILabel = {
        let label = UILabel()
        label.font = blodFontWithSize(13)
        label.textColor = UIColor(named: "color_title_black")
        label.text = "名次"
        return label
    }()

    let nameLabel:UILabel = {
        let label = UILabel()
        label.font = blodFontWithSize(13)
        label.textColor = UIColor(named: "color_title_black")
        label.text = "用户名"
        return label
    }()

    let scoreLabel:UILabel = {
        let label = UILabel()
        label.font = blodFontWithSize(13)
        label.textColor = UIColor(named: "color_title_black")
        label.text = "最高分"
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(named: "color_theme")
        self.clipsToBounds = true
        
        sebViews()
    }
    
    func sebViews() {
        
        self.addSubview(titleLabel)
        self.addSubview(tipView)
        self.addSubview(iconImageView)
        self.addSubview(bgView)
        
        self.addSubview(rankLabel)
        self.addSubview(nameLabel)
        self.addSubview(scoreLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(10)
        }
        
        tipView.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.centerY.equalTo(titleLabel)
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
        
        iconImageView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalTo(titleLabel)
            make.width.equalTo(8)
            make.height.equalTo(12)
        }

        bgView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(30)
        }
        
        rankLabel.snp.makeConstraints { (make) in
            make.left.equalTo(bgView).offset(15)
            make.centerY.equalTo(bgView)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(rankLabel.snp.right).offset(15)
            make.centerY.equalTo(bgView)
        }

        scoreLabel.snp.makeConstraints { (make) in
            make.right.equalTo(bgView).offset(-15)
            make.centerY.equalTo(bgView)
        }
    }
}


class EmptyCell: UITableViewCell {
    
    let circlerImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_helpCircler")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor(named: "color_title_black")
        return imageView
    }()
    
    let iconImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_empty")
        return imageView
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.font = fontWithSize(13)
        label.textColor = UIColor(named: "color_title_black")
        label.text = "没有授权，无法获取更多信息"
        return label
    }()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.clipsToBounds = true
        self.selectionStyle = .none;
        self.contentView.backgroundColor = UIColor(named: "color_theme")
        sebViews()
    }
    
    func sebViews() {

        self.contentView.addSubview(circlerImageView)
        self.contentView.addSubview(iconImageView)
        self.contentView.addSubview(titleLabel)
        
        circlerImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.right.equalToSuperview().offset(-25)
            make.height.width.equalTo(40)
        }
        
        iconImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(80)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(250)
        }

        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconImageView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }

    }
}

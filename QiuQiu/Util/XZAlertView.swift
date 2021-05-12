//
//  XZAlertView.swift
//  QiuQiu
//
//  Created by gozap on 2021/4/19.
//

import UIKit

@objcMembers
class XZAlertView: UIView {

    var gameCompletion:(() -> Void)?
    var completion:(() -> Void)?
    var index:Int?
    init() {
        super.init(frame: CGRect(x: 30, y: kScreenHeight / 2.0 - 200, width: kScreenWidth - 60 , height: 300))
        
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 10;
        self.clipsToBounds = true
    
        self.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(10)
            make.width.equalTo(100)
            make.height.equalTo(105)
        }

        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.iconImageView.snp.bottom).offset(-10)
            make.centerX.equalToSuperview()
        }

        self.addSubview(gameButton)
        gameButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(-30)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(45)
        }
        
        self.addSubview(doneButton)
        doneButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.gameButton.snp.top).offset(-20)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(45)
        }

        doneButton.addTarget(self, action: #selector(done), for: .touchUpInside)
        gameButton.addTarget(self, action: #selector(game), for: .touchUpInside)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func done() {
        self.completion?()
        hide()
    }
    
    @objc func game() {
        self.gameCompletion?()
        hide()
    }
    
    let iconImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "gameOverImage")
        return imageView
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.text = "很遗憾"
        label.font = fontWithSize(18)
        label.textColor = UIColor(hexString: "333333")
        return label
    }()
    
    let doneButton:UIButton = {
        let btn = UIButton()
        btn.setTitle("退出", for: .normal)
        btn.backgroundColor = UIColor(named: "color_black")
        btn.layer.cornerRadius = 10
        btn.clipsToBounds = true
        btn.setTitleColor(UIColor(named: "color_white"), for: .normal)
        btn.titleLabel?.font = fontWithSize(18)
        return btn
    }()
    
    let gameButton:UIButton = {
        let btn = UIButton()
        btn.setTitle("再来一局", for: .normal)
        btn.backgroundColor = UIColor(named: "color_black")
        btn.layer.cornerRadius = 10
        btn.clipsToBounds = true
        btn.setTitleColor(UIColor(named: "color_white"), for: .normal)
        btn.titleLabel?.font = fontWithSize(18)
        return btn
    }()
    
    let panel:UIView = {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor(white: 0, alpha: 0.6)
        view.isUserInteractionEnabled = true
        return view
    }()
    @objc func show() {
        let window = Client.shared.mainWindow
        window.addSubview(panel)
        window.addSubview(self)
        
        panel.alpha = 0
        self.alpha = 0
        self.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        
        UIView.animate(withDuration: 0.3) {
            self.panel.alpha = 1
            self.alpha = 1
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
    func hide() {
        UIView.animate(withDuration: 0.3, animations: {
            self.panel.alpha = 0
            self.alpha = 0
            self.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        }) { (_) in
            self.panel.removeFromSuperview()
            self.removeFromSuperview()
        }
    }

}

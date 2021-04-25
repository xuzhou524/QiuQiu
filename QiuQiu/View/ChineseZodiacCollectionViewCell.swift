//
//  ChineseZodiacCollectionViewCell.swift
//  QiuQiu
//
//  Created by xuzhou on 2021/4/16.
//

import UIKit

class ChineseZodiacCollectionViewCell: UICollectionViewCell {
    
    let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 0.3
        view.layer.shadowRadius = 3
        
        view.layer.cornerRadius = 5

        return view;
    }()
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView;
    }()
    
    let selImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_NoSelectTuAN")
        return imageView;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = UIColor.clear
        
        self.contentView.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(10)
            make.right.bottom.equalToSuperview().offset(-10)
        }
        
        bgView.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        bgView.addSubview(selImageView)
        selImageView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-2)
            make.top.equalToSuperview().offset(2)
            make.width.height.equalTo(18)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  ChineseZodiacViewController.swift
//  QiuQiu
//
//  Created by xuzhou on 2021/4/12.
//

import UIKit

class ChineseZodiacViewController: UIViewController {

    let label:UILabel = {
        let label = UILabel()
        label.font = blodFontWithSize(13)
        label.numberOfLines = 0
        label.textColor = UIColor(named: "color_title_black")
        label.text = "注：选择您喜欢的 || 您自己属相的 || 您讨厌的生肖图案吧！"
        return label
    }()
    
    let collectionView:UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout();
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.itemSize = CGSize(width: (kScreenWidth - 20) / 3.00, height: (kScreenWidth - 20) / 3.00)
        let collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width:kScreenWidth, height: kScreenHeight), collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor(named: "color_theme")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(ChineseZodiacCollectionViewCell.self, forCellWithReuseIdentifier: "ChineseZodiacCollectionViewCell")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "选择生肖图案";
        self.view.backgroundColor = UIColor(named: "color_theme")

        self.view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
        }
        
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(8)
            make.top.equalTo(self.label.snp.bottom).offset(15)
            make.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
        }
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }

}

extension ChineseZodiacViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChineseZodiacCollectionViewCell", for: indexPath) as! ChineseZodiacCollectionViewCell
        cell.logoImageView.image = UIImage(named: "BubbleFlat_" + "\(indexPath.row + 1)")
        if ((indexPath.row + 1) == XZGameDecorateConfig.shared.gameThemeChineseZodiacType){
            cell.selImageView.image = UIImage(named: "ic_SelectTuAN")
        }else{
            cell.selImageView.image = UIImage(named: "ic_NoSelectTuAN")
        }
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        XZGameDecorateConfig.shared.gameThemeChineseZodiacType = indexPath.row + 1
        self.collectionView.reloadData()
    }
}

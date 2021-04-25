//
//  UserViewController.swift
//  QiuQiu
//
//  Created by xuzhou on 2021/4/12.
//

import UIKit
import StoreKit

class UserViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var tableView: UITableView = {
        let tableView = UITableView();
        tableView.backgroundColor = UIColor(named: "color_theme")
        tableView.separatorStyle = .none
        
        regClass(tableView, cell: LeftTitleTableViewCell.self)
        
        return tableView
    }()
    
    let bgImageView:UIImageView = {
        let imageView = UIImageView.init(frame: CGRect(x: 15, y: 20, width: kScreenWidth - 30, height: 120))
        imageView.image = UIImage(named: "ic_cow")
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = GameUserInfoConfig.shared.gameName
        self.view.backgroundColor = UIColor(named: "color_theme")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView);
        self.tableView.snp.makeConstraints{ (make) -> Void in
            make.top.right.bottom.left.equalTo(self.view);
        }
        
        let views = UIView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 140))

        views.addSubview(self.bgImageView);
        
        tableView.tableHeaderView = views
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        }
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let bgView = UIView()
        bgView.backgroundColor = UIColor(named: "color_theme")
        return bgView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = getCell(tableView, cell: LeftTitleTableViewCell.self, indexPath: indexPath)
            cell.nodeNameLabel.text = ["选择生肖图案","知识墙","分享生肖来了"][indexPath.row]
            let names = ["ic_setting","ic_setQiang","ic_share"]
            cell.nodeImageView.image = UIImage(named: names[indexPath.row])?.withRenderingMode(.alwaysTemplate)
            cell.isHiddenRightImage(hidden: false)
            cell.summeryLabel.isHidden = true
            if indexPath.row == 0 {
                cell.panel.addRoundedCorners(corners: [.topLeft,.topRight], radii: CGSize(width: 8, height: 8), rect: CGRect(x: 0, y: 0, width: kScreenWidth - 30, height: 64))
            }else if (indexPath.row == 2){
                cell.panel.addRoundedCorners(corners: [.bottomLeft,.bottomRight], radii: CGSize(width: 8, height: 8), rect: CGRect(x: 0, y: 0, width: kScreenWidth - 30, height: 64))
            }else{
                cell.panel.layer.mask = nil
            }
            return cell
        }else{
            let cell = getCell(tableView, cell: LeftTitleTableViewCell.self, indexPath: indexPath)
            cell.nodeNameLabel.text = ["帮助中心","给个赞","隐私协议","版本号"][indexPath.row]
            let names = ["ic_help","ic_givePraise","ic_privacy","ic_settings_input_svideo"]
            cell.nodeImageView.image = UIImage(named: names[indexPath.row])?.withRenderingMode(.alwaysTemplate)
            if indexPath.row == 0 {
                cell.panel.addRoundedCorners(corners: [.topLeft,.topRight], radii: CGSize(width: 8, height: 8), rect: CGRect(x: 0, y: 0, width: kScreenWidth - 30, height: 64))
            }else if (indexPath.row == 3){
                cell.panel.addRoundedCorners(corners: [.bottomLeft,.bottomRight], radii: CGSize(width: 8, height: 8), rect: CGRect(x: 0, y: 0, width: kScreenWidth - 30, height: 64))
            }else{
                cell.panel.layer.mask = nil
            }
            if indexPath.row == 3 {
                cell.isHiddenRightImage(hidden: true)
                let infoDict = Bundle.main.infoDictionary
                if let info = infoDict {
                   // app版本
                   let appVersion = info["CFBundleShortVersionString"] as! String?
                   cell.summeryLabel.text = "v" + appVersion!
                   cell.summeryLabel.isHidden = false
                }
            }else{
                cell.isHiddenRightImage(hidden: false)
                cell.summeryLabel.isHidden = true
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                self.navigationController?.pushViewController(ChineseZodiacViewController(), animated: true)
            }else if (indexPath.row == 1){
                self.navigationController?.pushViewController(KnowledgeWindowViewController(), animated: true)
            }else if (indexPath.row == 2){
                let activityController = UIActivityViewController(activityItems: ["https://apps.apple.com/cn/app/id1563693082" + " (分享来自@生肖来了) " ], applicationActivities: nil)
                UIApplication.shared.windows.first?.rootViewController?.present(activityController, animated: true, completion: nil)
            }
        }else{
            if indexPath.row == 0 {
                self.navigationController?.pushViewController(HelpViewController(), animated: true)
            }else if indexPath.row == 1 {
                #if DEBUG
                #else
                    SKStoreReviewController.requestReview()
                #endif
            }else if indexPath.row == 2 {
                let webViewVC = BPYWebViewController.init(url: "https://www.gezhipu.com/shengxiao.pdf", titleStr: "隐私协议")
                self.navigationController?.pushViewController(webViewVC, animated: true)
            }
        }
    }
    
}

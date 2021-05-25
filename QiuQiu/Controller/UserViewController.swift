//
//  UserViewController.swift
//  QiuQiu
//
//  Created by xuzhou on 2021/4/12.
//

import UIKit
import StoreKit
import SwiftyStoreKit

class UserViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var isHaveBuy = false
    
    var tableView: UITableView = {
        let tableView = UITableView();
        tableView.backgroundColor = UIColor(named: "color_theme")
        tableView.separatorStyle = .none
        
        regClass(tableView, cell: LeftTitleTableViewCell.self)
        regClass(tableView, cell: LeftTitleBuyTableViewCell.self)
        
        return tableView
    }()
    
    let bgImageView:UIImageView = {
        let imageView = UIImageView.init(frame: CGRect(x: 15, y: 20, width: kScreenWidth - 30, height: 120))
        imageView.image = UIImage(named: "ic_cow")
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        restorePurchases()
    }

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
            return 4
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
            if indexPath.row == 0 {
                let cell = getCell(tableView, cell: LeftTitleBuyTableViewCell.self, indexPath: indexPath)
                cell.nodeImageView.image = UIImage(named: "ic_QuAd")?.withRenderingMode(.alwaysTemplate)
                cell.isHiddenRightImage(hidden: false)
                cell.summeryLabel.isHidden = true
                cell.panel.addRoundedCorners(corners: [.topLeft,.topRight], radii: CGSize(width: 8, height: 8), rect: CGRect(x: 0, y: 0, width: kScreenWidth - 30, height: 64))
                cell.nodeNameLabel.text = "去广告"
                if self.isHaveBuy {
                    cell.vipBtn.setTitle("已购买", for: .normal)
                }else{
                    cell.vipBtn.setTitle("购买", for: .normal)
                }
                return cell
            }else{
                let cell = getCell(tableView, cell: LeftTitleTableViewCell.self, indexPath: indexPath)
                cell.nodeNameLabel.text = ["","选择生肖图案","知识墙","分享生肖来了"][indexPath.row]
                let names = ["","ic_setting","ic_setQiang","ic_share"]
                cell.nodeImageView.image = UIImage(named: names[indexPath.row])?.withRenderingMode(.alwaysTemplate)
                cell.isHiddenRightImage(hidden: false)
                cell.summeryLabel.isHidden = true
                if (indexPath.row == 3){
                    cell.panel.addRoundedCorners(corners: [.bottomLeft,.bottomRight], radii: CGSize(width: 8, height: 8), rect: CGRect(x: 0, y: 0, width: kScreenWidth - 30, height: 64))
                }else{
                    cell.panel.layer.mask = nil
                }
                return cell
            }
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
                if self.isHaveBuy {
                    return
                }
                //再次验证
                MBProgressHUD.showDefaultIndicator(withText: nil)
                let receipt = AppleReceiptValidator(service: .production)
                SwiftyStoreKit.verifyReceipt(using: receipt) { (result) in
                    switch result {
                    case .success(let receipt):
                        MBProgressHUD.hideAllIndicator()
                        print("receipt--->\(receipt)")
                        self.isHaveBuy = true
                        self.tableView.reloadData()
                        break
                    case .error(let error):
                        print("error--->\(error)")
                        self.buyProduct()
                        break
                    }
                }
            }else if indexPath.row == 1 {
                self.navigationController?.pushViewController(ChineseZodiacViewController(), animated: true)
            }else if (indexPath.row == 2){
                self.navigationController?.pushViewController(KnowledgeWindowViewController(), animated: true)
            }else if (indexPath.row == 3){
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

extension UserViewController{
    func buyProduct() {
        SwiftyStoreKit.purchaseProduct("Watermelon_Pro", quantity: 1, atomically: true) { result in
            MBProgressHUD.hideAllIndicator()
            switch result {
            case .success(let purchase):
                print("Purchase Success: \(purchase.productId)")
                self.isHaveBuy = true
                self.tableView.reloadData()
            case .error(let error):
                switch error.code {
                case .unknown: print("Unknown error. Please contact support")
                case .clientInvalid: print("Not allowed to make the payment")
                case .paymentCancelled: break
                case .paymentInvalid: print("The purchase identifier was invalid")
                case .paymentNotAllowed: print("The device is not allowed to make the payment")
                case .storeProductNotAvailable: print("The product is not available in the current storefront")
                case .cloudServicePermissionDenied: print("Access to cloud service information is not allowed")
                case .cloudServiceNetworkConnectionFailed: print("Could not connect to the network")
                case .cloudServiceRevoked: print("User has revoked permission to use this cloud service")
                default:
                    break
                }
            }
        }
    }
    
    //验证
//    func product() {
//        let receipt = AppleReceiptValidator(service: .production)
//        SwiftyStoreKit.verifyReceipt(using: receipt) { (result) in
//            switch result {
//            case .success(let receipt):
//             print("receipt--->\(receipt)")
//                self.isHaveBuy = true
//                self.collectionView.reloadData()
//                break
//            case .error(let error):
//                print("error--->\(error)")
//                break
//            }
//        }
//    }
    
    func restorePurchases() {
        SwiftyStoreKit.restorePurchases { (result) in
            if let sss = result.restoredPurchases as [Purchase]?  {
                for score in sss {
                    if score.productId == "Watermelon_Pro" {
                        self.isHaveBuy = true
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
}

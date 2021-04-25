//
//  Client.swift
//  JuWan
//
//  Created by gozap on 2021/3/29.
//

import UIKit

/// 将代码安全的运行在主线程
func dispatch_sync_safely_main_queue(_ block: ()->()) {
    if Thread.isMainThread {
        block()
    } else {
        DispatchQueue.main.sync {
            block()
        }
    }
}

func fontWithSize(_ size:CGFloat) -> UIFont{
    return UIFont.systemFont(ofSize: size)
}
func blodFontWithSize(_ size:CGFloat) -> UIFont{
    return UIFont.boldSystemFont(ofSize: size)
}
func lightFontWithSize(_ size:CGFloat) -> UIFont{
    UIFont.systemFont(ofSize: size, weight: .thin)
    return UIFont(name: "Helvetica-Light", size: size)!
}
func weightFontWithSize(_ size:CGFloat, weight:UIFont.Weight) -> UIFont{
    return UIFont.systemFont(ofSize: size, weight: weight)
}

let kHalfPixel = 1 / UIScreen.main.scale

//屏幕宽高
let kScreenWidth  = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height

let kIsFullScreen = (UIApplication.shared.windows[0].safeAreaInsets.bottom > 0 ? true : false)

class FZImageView: UIImageView {
    var hitTestSlop:UIEdgeInsets = UIEdgeInsets.zero
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if hitTestSlop == UIEdgeInsets.zero {
            return super.point(inside: point, with:event)
        }
        else{
            return self.bounds.inset(by: hitTestSlop).contains(point)
        }
    }
}

class Client: NSObject {

}


extension UIView {
    /// 设置阴影
    /// - Parameters:
    ///   - color: 阴影颜色
    ///   - offset: 阴影偏移量
    ///   - opacity: 阴影透明度
    ///   - radius: 阴影半径
    func addShadow(color: UIColor, offset:CGSize, opacity:Float, radius:CGFloat) {
//        self.layer.masksToBounds = true
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
        
        let shadowRect: CGRect? = CGRect.init(x: -radius, y: -radius, width: bounds.size.width + 2 * radius, height: bounds.size.height + 2 * radius)

        self.layer.shadowPath = UIBezierPath.init(rect: shadowRect!).cgPath
    
    }
    
    func addRoundedCorners(corners:UIRectCorner,radii:CGSize,rect:CGRect) {
        let rounded = UIBezierPath.init(roundedRect: rect, byRoundingCorners: corners, cornerRadii: radii)
        let shape = CAShapeLayer()
        shape.path = rounded.cgPath
        self.layer.mask = shape
    }
}

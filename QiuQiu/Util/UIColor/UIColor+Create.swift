//
//  UIColor+Create.swift
//  JuWan
//
//  Created by gozap on 2021/3/29.
//

import UIKit

extension UIColor {
    convenience public init(r255:CGFloat, g255:CGFloat, b255:CGFloat, a255:CGFloat = 255) {
        self.init(red: r255/255, green: g255/255, blue: b255/255, alpha: a255/255)
    }
    
    class func color(red:CGFloat , green:CGFloat, blue:CGFloat, alpha:CGFloat = 255) -> UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha/255)
    }
    
    class func image(color:UIColor, size:CGSize = CGSize(width: 1, height: 1)) -> UIImage{
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(CGRect(origin: CGPoint.zero, size: size))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image! //context应该不会没get到吧~ 所以直接强解了
    }
    
    func image(size:CGSize = CGSize(width: 1, height: 1)) -> UIImage{
        return UIColor.image(color: self, size: size)
    }
    var image: UIImage {
        return UIColor.image(color: self)
    }
}

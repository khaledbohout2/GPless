//
//  UIImageView.swift
//  GPless
//
//  Created by Khaled Bohout on 11/18/20.
//

import Foundation
import UIKit

extension UIImage {

    class func imageWithColor(color: UIColor, size: CGSize) -> UIImage {
        
        let rect: CGRect = CGRect(origin: .zero, size: CGSize(width: size.width, height: size.height))
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    

}


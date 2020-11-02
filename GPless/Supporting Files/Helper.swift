//
//  Helper.swift
//  GPless
//
//  Created by Khaled Bohout on 11/1/20.
//

import Foundation
import UIKit

func makeTopCornerRadius(myView: UIView) {
    
    let rectShape = CAShapeLayer()
    rectShape.bounds = myView.frame
    rectShape.position = myView.center
    rectShape.path = UIBezierPath(roundedRect: myView.bounds, byRoundingCorners: [.topRight, .topLeft, .bottomLeft, .bottomRight], cornerRadii: CGSize(width: 35, height: 35)).cgPath

   //  myView.layer.backgroundColor = UIColor.green.cgColor
    //Here I'm masking the textView's layer with rectShape layer
     myView.layer.mask = rectShape
}

func makeBottomCornerRadius(myView: UIView) {
    
    let rectShape = CAShapeLayer()
    rectShape.bounds = myView.frame
    rectShape.position = myView.center
    rectShape.path = UIBezierPath(roundedRect: myView.bounds, byRoundingCorners: [.bottomRight, .bottomLeft], cornerRadii: CGSize(width: 35, height: 35)).cgPath

   //  myView.layer.backgroundColor = UIColor.green.cgColor
    //Here I'm masking the textView's layer with rectShape layer
     myView.layer.mask = rectShape
}

func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }

    if ((cString.count) != 6) {
        return UIColor.gray
    }

    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)

    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

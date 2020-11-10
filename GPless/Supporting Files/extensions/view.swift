//
//  view.swift
//  GPless
//
//  Created by Khaled Bohout on 11/1/20.
//

import UIKit
@IBDesignable extension UIView {
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
   

}

@IBDesignable extension UIView {
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}


extension String {
    func removeLastLine()->String {
        var comps = self.split(separator: "\n")
        comps.removeLast()
        var outputString = ""
        var br = ""
        for sub in comps {
            outputString.append(br+String(sub))
            br = "\n"
        }
        return outputString
    }
}


 extension UITextView {
    func removeLastLine(){
        var comps = self.text.split(separator: "\n")
        comps.removeLast()
        var outputString = ""
        var br = ""
        for sub in comps {
             outputString.append(br+String(sub))
            br = "\n"
        }
        self.text = outputString
    }
}
extension CGRect{
    init(_ x:CGFloat,_ y:CGFloat,_ w:CGFloat , _ h:CGFloat) {
        self.init(x:x,y:y,width:w,height:h)
    }
}

extension UIView {
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
}

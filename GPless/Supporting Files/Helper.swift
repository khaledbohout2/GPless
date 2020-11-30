//
//  Helper.swift
//  GPless
//
//  Created by Khaled Bohout on 11/1/20.
//

import Foundation
import UIKit
import SystemConfiguration

func getCurrentDate() -> String {
    let today = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.locale = Locale(identifier: "en_US")
    return (formatter.string(from: today))
}

func getLastWeakDate() -> String {
    
    let lastWeekDate = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: Date())!
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US")
    formatter.dateFormat = "yyyy-MM-dd"
    return (formatter.string(from: lastWeekDate))
}


func makeTopCornerRadius(myView: UIView) {
    
    let rectShape = CAShapeLayer()
    rectShape.bounds = myView.frame
    rectShape.position = myView.center
    rectShape.path = UIBezierPath(roundedRect: myView.bounds, byRoundingCorners: [.topRight, .topLeft,], cornerRadii: CGSize(width: 50, height: 50)).cgPath

   //  myView.layer.backgroundColor = UIColor.green.cgColor
    //Here I'm masking the textView's layer with rectShape layer
     myView.layer.mask = rectShape
}

func makeCornerRadius(myView: UIView) {
    
    let rectShape = CAShapeLayer()
    rectShape.bounds = myView.frame
    rectShape.position = myView.center
    rectShape.path = UIBezierPath(roundedRect: myView.bounds, byRoundingCorners: [.bottomRight, .bottomLeft, .topLeft, .topRight], cornerRadii: CGSize(width: 20, height: 20)).cgPath

   //  myView.layer.backgroundColor = UIColor.green.cgColor
    //Here I'm masking the textView's layer with rectShape layer
     myView.layer.mask = rectShape
}

func makeBottomCornerRadius(myView: UIView) {
    
    let rectShape = CAShapeLayer()
    rectShape.bounds = myView.frame
    rectShape.position = myView.center
    rectShape.path = UIBezierPath(roundedRect: myView.bounds, byRoundingCorners: [.bottomRight, .bottomLeft], cornerRadii: CGSize(width: 50, height: 50)).cgPath

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

 func getUserData()->Bool{
    let def = UserDefaults.standard
    return (def.object(forKey: "accessToken") as? String) != nil
}

func getaccessToken()->String{
   let def = UserDefaults.standard
    return def.object(forKey: "accessToken") as! String
}

func setUserData(user: User){
    let def = UserDefaults.standard
    
    
    def.setValue(user.id, forKey: "id")
    def.setValue(user.phone, forKey: "phone")
    def.setValue(user.fullName, forKey: "fullName")
    def.setValue(user.accountType, forKey: "accountType")
    def.setValue(user.email, forKey: "email")
    def.setValue(user.tokens?.accessToken, forKey: "accessToken")
    def.setValue(user.address, forKey: "address")
    def.setValue(user.createdAt, forKey: "createdAt")
    def.setValue(user.loginMethod, forKey: "loginMethod")
    def.setValue(user.promoCode, forKey: "promoCode")
    def.setValue(user.tokens?.refreshToken, forKey: "refreshToken")
    
    def.synchronize()
    //        restartApp()
    
}

func logout(){
    
    let def = UserDefaults.standard
    
    def.removeObject(forKey: "id")
    def.removeObject(forKey: "phone")
    def.removeObject(forKey: "fullName")
    def.removeObject(forKey: "accountType")
    def.removeObject(forKey: "email")
    def.removeObject(forKey: "accessToken")
    def.removeObject(forKey: "address")
    def.removeObject(forKey: "createdAt")
    def.removeObject(forKey: "loginMethod")
    def.removeObject(forKey: "promoCode")
    def.removeObject(forKey: "refreshToken")
}

public class Reachable  {
    
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
        
    }
    

    
}

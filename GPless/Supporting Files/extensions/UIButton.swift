//
//  UIButton.swift
//  GPless
//
//  Created by Khaled Bohout on 12/16/20.
//

import Foundation

extension UIButton {
    
    func setLocalization() {
        
        let font = self.titleLabel?.font.fontName
        
        let size = self.titleLabel?.font.pointSize
        
        let newFont = font?.localizableString()
    
        self.titleLabel?.font =  UIFont(name: newFont!, size: size!)
        
    }
}

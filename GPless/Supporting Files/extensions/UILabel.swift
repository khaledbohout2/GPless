//
//  UILabel.swift
//  GPless
//
//  Created by Khaled Bohout on 12/16/20.
//

import Foundation

extension UILabel {
    
    func setLocalization() {
        
        let font = self.font.fontName
        
        let size = self.font.pointSize
        
        let newFont = font.localizableString()

        self.font = UIFont(name: newFont, size: size)

    }
}

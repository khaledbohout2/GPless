//
//  String.swift
//  GPless
//
//  Created by Khaled Bohout on 12/14/20.
//

import Foundation

extension String {
    
    func localizableString() -> String {
        
        return NSLocalizedString(self, comment: "")
    }
}

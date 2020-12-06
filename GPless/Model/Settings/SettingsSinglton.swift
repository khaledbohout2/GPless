//
//  SettingsSinglton.swift
//  GPless
//
//  Created by Khaled Bohout on 12/6/20.
//

import Foundation

final class SharedSettings {
    
    static var shared = SharedSettings()
    var settings: Settings?
    
    private init() { }
}

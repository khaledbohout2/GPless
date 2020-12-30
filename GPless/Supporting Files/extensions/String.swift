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
    

        var htmlToAttributedString: NSAttributedString? {
            guard let data = data(using: .utf8) else { return nil }
            do {
                return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
            } catch {
                return nil
            }
        }
        var htmlToString: String {
            return htmlToAttributedString?.string ?? ""
        }
    
}

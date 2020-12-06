//
//  SettingsRequet.swift
//  GPless
//
//  Created by Khaled Bohout on 12/3/20.
//

import Foundation

final class SettingsRequet: Requestable {
    
    typealias ResponseType = Settings
    private var index: String?
    
    init(index: String) {
        
        self.index = index
    }
    
    var baseUrl: URL {
        return  URL(string: URLS.baseURL)!
    }
    
    var endpoint: String {
        
        return "api/settings"
    }
    
    var method: Network.Method {
        return .get
    }
    
    var query: Network.QueryType {
        return .path
    }
    
    var parameters: [String : Any]? {
        
        return ["index" : self.index!]
    }
    
    var headers: [String : String]? {

        return defaultJSONHeader
    }
    
    var timeout: TimeInterval {
        return 30.0
    }
    
    var cachePolicy: NSURLRequest.CachePolicy {
        return .reloadIgnoringLocalAndRemoteCacheData
    }
}

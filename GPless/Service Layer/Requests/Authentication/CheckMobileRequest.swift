//
//  CheckMobileRequest.swift
//  GPless
//
//  Created by Khaled Bohout on 12/17/20.
//

import Foundation

final class CheckMobileRequest: Requestable {
    
    typealias ResponseType = Int
    
    private var mobile: String
    
    init(mobile: String) {

        self.mobile = mobile
    }
    
    var baseUrl: URL {
        
        return  URL(string: URLS.baseURL)!
    }
    
    var endpoint: String {
        
        return "api/validatephone/\(mobile)"
    }
    
    var method: Network.Method {
        return .get
    }
    
    var query: Network.QueryType {
        return .path
    }
    
    var parameters: [String : Any]? {
        
        return nil
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


//
//  MallsRequest.swift
//  GPless
//
//  Created by Khaled Bohout on 12/2/20.
//

import Foundation

final class MallsRequest: Requestable {
    
    typealias ResponseType = Malls
    private var index: String?
    
    init(index: String) {
        
        self.index = index
    }
    
    var baseUrl: URL {
        return  URL(string: URLS.baseURL)!
    }
    
    var endpoint: String {
        
        return "api/malls"
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

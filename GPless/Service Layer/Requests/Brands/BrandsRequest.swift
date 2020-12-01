//
//  BrandsRequest.swift
//  GPless
//
//  Created by Khaled Bohout on 11/22/20.
//

import Foundation

final class BrandsRequest: Requestable {
    
    typealias ResponseType = Brands
    
    private var index: String!
    private var featured: Bool!
    
    init(index: String, featured: Bool) {
        self.index = index
        self.featured = featured
    }
    
    var baseUrl: URL {
        return  URL(string: URLS.baseURL)!
    }
    
    var endpoint: String {
        
        return "api/brands"
    }
    
    var method: Network.Method {
        return .get
    }
    
    var query: Network.QueryType {
        return .path
    }
    
    var parameters: [String : Any]? {
        
        if self.featured {
            return ["index" : self.index!, "featured" : "1"]
        } else {
            
            return ["index" : self.index!]
        }
        
        
        
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


//
//  CategorySearchRequest.swift
//  GPless
//
//  Created by Khaled Bohout on 12/17/20.
//

import Foundation

final class CategorySearchRequest: Requestable {
    
    typealias ResponseType = Category
    
    private var value: String
    
    init(value: String) {

        self.value = value

    }
    
    var baseUrl: URL {
        return  URL(string: URLS.baseURL)!
    }
    
    var endpoint: String {
        
        return "api/categories/search"
    }
    
    var method: Network.Method {
        return .get
    }
    
    var query: Network.QueryType {
        return .path
    }
    
    var parameters: [String : Any]? {
        
        let param = ["value" : value]
        
        return param
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

//
//  RegisterRequest.swift
//  GPless
//
//  Created by Khaled Bohout on 11/19/20.


import Foundation

final class CategoriesRequest: Requestable {
    
    typealias ResponseType = Category
    
    private var index: String
    
    init(index: String) {

        self.index = index

    }
    
    var baseUrl: URL {
        return  URL(string: URLS.baseURL)!
    }
    
    var endpoint: String {
        
        return "api/categories/"
    }
    
    var method: Network.Method {
        return .get
    }
    
    var query: Network.QueryType {
        return .path
    }
    
    var parameters: [String : Any]? {
        
        let param = ["index" : index]
        
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

//
//  GetUserOffersRequest.swift
//  GPless
//
//  Created by Khaled Bohout on 11/22/20.
//

import Foundation

final class GetUserOffersRequest: Requestable {
    
    typealias ResponseType = OffersHistory
    
    var categoryType: String?
    
    init() {
    }
    
    var baseUrl: URL {
        return  URL(string: URLS.baseURL)!
    }
    
    var endpoint: String {
        
        return "api/user/offers"
    }
    
    var method: Network.Method {
        return .get
    }
    
    var query: Network.QueryType {
        return .path
    }
    
    var parameters: [String : Any]? {
        
        if categoryType != nil {
        
        return ["category_type" : self.categoryType!]
            
        } else {
            
            return nil
        }
    }
    
    var headers: [String : String]? {
        
        var header = ["Authorization": "Bearer " + getaccessToken(), "Accept" : "application/json"]
        for item in defaultJSONHeader {
            header.updateValue(item.value, forKey: item.key)
        }
        return header
    }
    
    var timeout: TimeInterval {
        return 30.0
    }
    
    var cachePolicy: NSURLRequest.CachePolicy {
        return .reloadIgnoringLocalAndRemoteCacheData
    }
}

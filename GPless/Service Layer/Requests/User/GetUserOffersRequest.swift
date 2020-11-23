//
//  GetUserOffersRequest.swift
//  GPless
//
//  Created by Khaled Bohout on 11/22/20.
//

import Foundation

final class GetUserOffersRequest: Requestable {
    
    typealias ResponseType = Offers
    
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

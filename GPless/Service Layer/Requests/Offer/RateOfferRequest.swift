//
//  RateOfferRequest.swift
//  GPless
//
//  Created by Khaled Bohout on 11/22/20.
//

import Foundation

final class RateOfferRequest: Requestable {
    
    typealias ResponseType = RateModel
    
    private var id: String
    private var value: String
    
    init(id: String, value: String) {

        self.id = id
        self.value = value

    }
    
    var baseUrl: URL {
        return  URL(string: URLS.baseURL)!
    }
    
    var endpoint: String {
        
        return "api/offers/\(self.id)/rates/\(self.value)"
    }
    
    var method: Network.Method {
        return .post
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


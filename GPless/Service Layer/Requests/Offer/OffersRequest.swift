//
//  RegisterRequest.swift
//  GPless
//
//  Created by Khaled Bohout on 11/19/20.



import Foundation

final class OffersRequest: Requestable {
    
    typealias ResponseType = Offers
    
    private var index: String
    private var type: String
    
    init(index: String, type: String) {

        self.index = index
        self.type = type

    }
    
    var baseUrl: URL {
        return  URL(string: URLS.baseURL)!
    }
    
    var endpoint: String {
        
        return "api/offers"
    }
    
    var method: Network.Method {
        return .get
    }
    
    var query: Network.QueryType {
        return .path
    }
    
    var parameters: [String : Any]? {
        
        let param = ["Index" : self.index, "type": self
                        .type]
        
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

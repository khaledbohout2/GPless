//
//  RegisterRequest.swift
//  GPless
//
//  Created by Khaled Bohout on 11/19/20.



import Foundation

final class OffersRequest: Requestable {
    
    typealias ResponseType = Offers
    
    private var indexType: String
    
    init(indexType: String) {

        self.indexType = indexType

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
        
        let param = ["Indextype" : self.indexType]
        
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

//
//  RegisterRequest.swift
//  GPless
//
//  Created by Khaled Bohout on 11/19/2020.



import Foundation

final class VendorOffers: Requestable {
    
    typealias ResponseType = Offers
    
    private var id: String
    
    init(id: String) {

        self.id = id

    }
    
    var baseUrl: URL {
        return  URL(string: URLS.baseURL)!
    }
    
    var endpoint: String {
        
        return "api/vendors/\(self.id)/offers"
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

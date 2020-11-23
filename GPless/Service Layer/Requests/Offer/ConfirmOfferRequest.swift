//
//  ConfirmOfferRequest.swift
//  GPless
//
//  Created by Khaled Bohout on 11/22/20.
//

import Foundation

final class ConfirmOfferRequest: Requestable {
    
    typealias ResponseType = [ConfirmOfferResponse]
    
    private var Ids: [String]?
    private var vendor_code: String?
    
    init(Ids: [String], vendor_code: String) {
        
        self.Ids = Ids
        self.vendor_code = vendor_code

    }
    
    var baseUrl: URL {
        return  URL(string: URLS.baseURL)!
    }
    
    var endpoint: String {
        
        return "api/offers/confirm"
    }
    
    var method: Network.Method {
        return .post
    }
    
    var query: Network.QueryType {
        return .path
    }
    
    var parameters: [String : Any]? {
        
        return ["Ids" : Ids! , "vendor_code" : vendor_code!]
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

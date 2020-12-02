//
//  UpdateOfferRatingRequest.swift
//  GPless
//
//  Created by Khaled Bohout on 12/2/20.
//

import Foundation

final class UpdateOfferRatingRequest: Requestable {
    
    typealias ResponseType = Bool
    
    private var id: String
    
    init(id: String) {

        self.id = id
    }
    
    var baseUrl: URL {
        return  URL(string: URLS.baseURL)!
    }
    
    var endpoint: String {
        
        return "api/offers/\(self.id)/rates"
    }
    
    var method: Network.Method {
        return .put
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

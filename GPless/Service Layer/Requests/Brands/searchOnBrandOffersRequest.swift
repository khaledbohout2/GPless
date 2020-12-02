//
//  searchOnBrandOffersRequest.swift
//  GPless
//
//  Created by Khaled Bohout on 12/2/20.
//

import Foundation

final class searchOnBrandOffersRequest: Requestable {
    
    typealias ResponseType = Offers
    
    private var id: String
    private var searchText: String
    
    init(id: String, searchText: String) {

        self.id = id
        self.searchText = searchText
        

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
        
        return ["Value" : searchText]
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

//
//  RegisterRequest.swift
//  GPless
//
//  Created by Khaled Bohout on 11/19/2020.



import Foundation

final class FilterdOffersRequest: Requestable {
    
    typealias ResponseType = FilterResponse
    
    private var filter: Filter
    
    init(filter: Filter) {

        self.filter = filter

    }
    
    var baseUrl: URL {
        return  URL(string: URLS.baseURL)!
    }
    
    var endpoint: String {
        
        return "api/offers/filter"
    }
    
    var method: Network.Method {
        return .get
    }
    
    var query: Network.QueryType {
        return .path
    }
    
    var parameters: [String : Any]? {
        
        let param = try? filter.asDictionary()
        
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

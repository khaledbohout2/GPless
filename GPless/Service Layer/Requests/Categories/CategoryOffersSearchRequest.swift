//
//  CategoryOffersSearchRequest.swift
//  GPless
//
//  Created by Khaled Bohout on 12/2/20.
//

import Foundation

final class CategoryOffersSearchRequest: Requestable {
    
    typealias ResponseType = SearchResult
    
    private var value: String?
    private var categoryType: String?
    
    init(value: String, categoryType: String) {
        self.value = value
        self.categoryType = categoryType
    }
    
    var baseUrl: URL {
        return  URL(string: URLS.baseURL)!
    }
    
    var endpoint: String {
        
        return "api/offers/search"
    }
    
    var method: Network.Method {
        return .get
    }
    
    var query: Network.QueryType {
        return .path
    }
    
    var parameters: [String : Any]? {

        return ["value" : value!, "category_type" : categoryType!]

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

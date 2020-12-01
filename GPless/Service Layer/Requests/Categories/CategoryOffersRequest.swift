//
//  CategoryOffersRequest.swift
//  GPless
//
//  Created by Khaled Bohout on 12/1/20.
//

import Foundation

final class CategoryOffersRequest: Requestable {
    
    typealias ResponseType = Offers
    
    private var index: String
    private var categoryType: String
    
    init(index: String, categoryType: String) {

        self.index = index
        self.categoryType = categoryType

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
        
        let param = ["index" : index, "category_type": categoryType]
        
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

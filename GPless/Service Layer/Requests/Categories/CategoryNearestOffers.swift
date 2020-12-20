//
//  CategoryNearestOffers.swift
//  GPless
//
//  Created by Khaled Bohout on 12/1/20.
//

import Foundation

final class CategoryNearestOffers: Requestable {
    
    typealias ResponseType = NearestOffersResponse
    
    private var location: Location
    private var categoryType: String
    
    init(location: Location, categoryType: String) {

        self.location = location
        self.categoryType = categoryType
    }
    
    var baseUrl: URL {
        return  URL(string: URLS.baseURL)!
    }
    
    var endpoint: String {
        
        return "api/offers/nearestoffers/"
    }
    
    var method: Network.Method {
        return .get
    }
    
    var query: Network.QueryType {
        return .path
    }
    
    var parameters: [String : Any]? {
        
        var param = ["category_type": categoryType]
        
        let locationDict = try? location.asDictionary()
        
        for item in locationDict! {
            param.updateValue(item.value as! String, forKey: item.key)
        }
        
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


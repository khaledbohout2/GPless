//
//  UserGetOfferRequest.swift
//  GPless
//
//  Created by Khaled Bohout on 12/2/20.
//

import Foundation

final class UserGetOfferRequest: Requestable {
    
    typealias ResponseType = UserGetOffer
    
    private var id: String
    private var count: Int
    
    init(id: String, count: Int) {
        
        self.id = id
        self.count = count
    }
    
    var baseUrl: URL {
        
        return  URL(string: URLS.baseURL)!
    }
    
    var endpoint: String {
        
        return "api/users/offers/\(id)/\(count)"
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
        
        var header = ["Authorization": "Bearer " + getaccessToken(), "Accept" : "application/json"]
        for item in defaultJSONHeader {
            header.updateValue(item.value, forKey: item.key)
        }
        return header
    }
    
    var timeout: TimeInterval {
        return 30.0
    }
    
    var cachePolicy: NSURLRequest.CachePolicy {
        return .reloadIgnoringLocalAndRemoteCacheData
    }
}

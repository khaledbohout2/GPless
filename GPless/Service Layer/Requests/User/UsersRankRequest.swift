//
//  UsersRankRequest.swift
//  GPless
//
//  Created by Khaled Bohout on 11/22/20.
//


import Foundation

final class UsersRankRequest: Requestable {
    
    typealias ResponseType = Int
    
    private var from: String
    private var to: String
    
    init(from: String, to: String) {
        
        self.from = from
        self.to = to

    }
    
    var baseUrl: URL {
        
        return  URL(string: URLS.baseURL)!
    }
    
    var endpoint: String {
        
        return "api/users/rank"
    }
    
    var method: Network.Method {
        return .get
    }
    
    var query: Network.QueryType {
        return .path
    }
    
    var parameters: [String : Any]? {

        return ["from": from, "to": to]
    }
    
    var headers: [String : String]? {
        
        var header = ["Authorization": "Bearer ." + getaccessToken(), "Accept" : "application/json"]
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


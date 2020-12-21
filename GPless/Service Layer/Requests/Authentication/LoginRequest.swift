//
//  LoginRequest.swift
//  GPless
//
//  Created by Khaled Bohout on 11/19/20.
//


import Foundation

final class LoginRequest: Requestable {
    
    typealias ResponseType = LoginResponse
    
    private var email: String
    private var password: String
    
    init(email: String, password: String) {

        self.email = email
        self.password = password
    }
    
    var baseUrl: URL {
        return  URL(string: URLS.baseURL)!
    }
    
    var endpoint: String {
        
        return "api/login"
    }
    
    var method: Network.Method {
        return .post
    }
    
    var query: Network.QueryType {
        return .path
    }
    
    var parameters: [String : Any]? {
        
        return ["email" : self.email, "password": self.password]
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


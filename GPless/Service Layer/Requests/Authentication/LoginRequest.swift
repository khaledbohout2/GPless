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
    private var loginMethod: String
    
    init(email: String, password: String, loginMethod: String) {

        self.email = email
        self.password = password
        self.loginMethod = loginMethod
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
        
        if loginMethod == "" {
        
        return ["email" : self.email, "password": self.password]
            
        } else {
            
            return ["email" : self.email, "login_method" : self.loginMethod]
        }
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


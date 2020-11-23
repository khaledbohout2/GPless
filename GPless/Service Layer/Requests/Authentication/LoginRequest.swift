//
//  LoginRequest.swift
//  GPless
//
//  Created by Khaled Bohout on 11/19/20.
//


import Foundation

final class LoginRequest: Requestable {
    
    typealias ResponseType = UserResponse
    
    private var user: UserToRegister
    
    init(user: UserToRegister) {

        self.user = user
    }
    
    var baseUrl: URL {
        return  URL(string: URLS.baseURL)!
    }
    
    var endpoint: String {
        
        return "login/"
    }
    
    var method: Network.Method {
        return .post
    }
    
    var query: Network.QueryType {
        return .path
    }
    
    var parameters: [String : Any]? {
        
        let param = try? user.asDictionary()
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


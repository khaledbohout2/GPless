//
//  RegisterRequest.swift
//  GPless
//
//  Created by Khaled Bohout on 11/19/2020.



import Foundation

final class RegisterRequest: Requestable {
    
    typealias ResponseType = User
    
    private var user: UserToRegister
    
    init(user: UserToRegister) {

        self.user = user
    }
    
    var baseUrl: URL {
        return  URL(string: URLS.baseURL)!
    }
    
    var endpoint: String {
        
        return "api/register/"
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

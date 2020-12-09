//
//  EditProfileRequest.swift
//  GPless
//
//  Created by Khaled Bohout on 12/9/20.
//

import Foundation

final class EditProfileRequest: Requestable {
    
    typealias ResponseType = String
    
    private var user: UserToRegister?
    
    
    init(user: UserToRegister) {
        self.user = user
    }
    
    var baseUrl: URL {
        return  URL(string: URLS.baseURL)!
    }
    
    var endpoint: String {
        
        return "api/users/\(getUserId())"
    }
    
    var method: Network.Method {
        return .put
    }
    
    var query: Network.QueryType {
        return .path
    }
    
    var parameters: [String : Any]? {
        
        let user = try! self.user?.asDictionary()
        
        return user
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


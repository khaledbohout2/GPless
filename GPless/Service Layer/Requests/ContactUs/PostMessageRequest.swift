//
//  PostMessageRequest.swift
//  GPless
//
//  Created by Khaled Bohout on 12/8/20.
//

import Foundation

final class PostMessageRequest: Requestable {
    
    typealias ResponseType = PostMessageResponse
    private var messageObject: PostMessage?
    
    init(messageObject: PostMessage) {
        
        self.messageObject = messageObject
    }
    
    var baseUrl: URL {
        return  URL(string: URLS.baseURL)!
    }
    
    var endpoint: String {
        
        return "api/contactus"
    }
    
    var method: Network.Method {
        return .post
    }
    
    var query: Network.QueryType {
        return .path
    }
    
    var parameters: [String : Any]? {
        
        let param = try! self.messageObject?.asDictionary()
        
        return param
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


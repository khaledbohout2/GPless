//
//  GetPhotoIconsRequest.swift
//  GPless
//
//  Created by Khaled Bohout on 11/22/20.
//

import Foundation

final class GetPhotoIconsRequest: Requestable {
    
    typealias ResponseType = [Icon]
    
    init() {

    }
    
    var baseUrl: URL {
        return  URL(string: URLS.baseURL)!
    }
    
    var endpoint: String {
        
        return "api/getphotos/icons"
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
        return defaultJSONHeader
    }
    
    var timeout: TimeInterval {
        return 30.0
    }
    
    var cachePolicy: NSURLRequest.CachePolicy {
        return .reloadIgnoringLocalAndRemoteCacheData
    }
}


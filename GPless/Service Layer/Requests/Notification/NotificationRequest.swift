//
//  NotificationRequest.swift
//  GPless
//
//  Created by Khaled Bohout on 12/2/20.
//

final class NotificationRequest: Requestable {
    
    typealias ResponseType = Notifications
    private var index: String?
    
    init(index: String) {
        self.index = index
    }
    
    var baseUrl: URL {
        return  URL(string: URLS.baseURL)!
    }
    
    var endpoint: String {
        
        return "api/notifications"
    }
    
    var method: Network.Method {
        return .get
    }
    
    var query: Network.QueryType {
        return .path
    }
    
    var parameters: [String : Any]? {
        
        return ["index" : self.index!]
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

//
//  RegisterRequest.swift
//  GPless
//
//  Created by Khaled Bohout on 11/19/20.



import Foundation

final class NearestOfferRequest: Requestable {
    
    typealias ResponseType = [NearestOffer]
    
    private var location: Location
    
    init(location: Location) {

        self.location = location

    }
    
    var baseUrl: URL {
        return  URL(string: URLS.baseURL)!
    }
    
    var endpoint: String {
        
        return "offers/nearestoffers/"
    }
    
    var method: Network.Method {
        return .get
    }
    
    var query: Network.QueryType {
        return .path
    }
    
    var parameters: [String : Any]? {
        
        let param = try? location.asDictionary()
        
        
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

//
//  ConfirmOfferRequest.swift
//  GPless
//
//  Created by Khaled Bohout on 11/22/20.
//

import Foundation

final class ConfirmOfferRequest: Requestable {
    
    typealias ResponseType = ConfirmOfferResponse
    
    private var confirmOffer: ConfirmOffer?
    
    init(confirmOffer: ConfirmOffer) {
        
        self.confirmOffer = confirmOffer
    }
    
    var baseUrl: URL {
        return  URL(string: URLS.baseURL)!
    }
    
    var endpoint: String {
        
        return "api/offers/confirm"
    }
    
    var method: Network.Method {
        return .post
    }
    
    var query: Network.QueryType {
        return .path
    }
    
    var parameters: [String : Any]? {
        
        let par = try! confirmOffer!.asDictionary()
        
        print(par)
        
        return par
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

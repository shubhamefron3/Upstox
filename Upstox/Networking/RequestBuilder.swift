//
//  RequestBuilder.swift
//  Upstox
//
//  Created by MacBook on 15/11/24.
//

import Foundation

final class RequestBuilder {
    static func buildRequest(for url: URL, 
                             method: String = NetworkMethods.get.rawValue ) -> URLRequest{
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        // Add any necessary headers
        return request
    }
}

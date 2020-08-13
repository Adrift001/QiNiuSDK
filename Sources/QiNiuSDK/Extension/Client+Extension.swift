//
//  File.swift
//  
//
//  Created by swifter on 2020/8/11.
//

import Vapor

public extension Client {
    
    func get(_ endpoint: Endpoint) -> EventLoopFuture<ClientResponse> {
        return get(endpoint.uri, headers: endpoint.headers)
    }
    
    func post(_ endpoint: Endpoint) -> EventLoopFuture<ClientResponse> {
        return post(endpoint.uri, headers: endpoint.headers, beforeSend: { req in
//            try req.content.encode(test, as: .formData)
            if let body = endpoint.body {
                try req.content.encode(body, as: .formData)
            }
        })
    }
    
    func put(_ endpoint: Endpoint) -> EventLoopFuture<ClientResponse> {
        return put(endpoint.uri, headers: endpoint.headers)
    }
    
    func delete(_ endpoint: Endpoint) -> EventLoopFuture<ClientResponse> {
        return delete(endpoint.uri, headers: endpoint.headers)
    }
    
}

//
//  File.swift
//  
//
//  Created by swifter on 2020/6/19.
//

import Foundation

public final class AuthorizationPlugin: PluginType {
    public func prepare(_ request: Request, target: TargetType) -> Request {
        var request = request
        var signingStr = ""
        signingStr.append(contentsOf: request.url.path)
        if let query = request.url.query, !query.isEmpty {
            signingStr.append(contentsOf: "?\(query)")
        }
        signingStr.append(contentsOf: "\n")
        request.headers.add(name: "Authorization", value: "QBox \(Auth.accessToken(signingStr: signingStr))")
        return request
    }
}

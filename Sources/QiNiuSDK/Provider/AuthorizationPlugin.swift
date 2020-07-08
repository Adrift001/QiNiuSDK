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
        let method = request.method
        let path = request.url.path
        let query = request.url.query == nil ? "" : "?\(request.url.query ?? "")"
        let host = request.host
        let contentType = request.headers["Content-Type"].first ?? ""
        let signingStr = """
        \(method) \(path)\(query)
        Host: \(host)
        Content-Type: \(contentType)


        """
        request.headers.add(name: "Authorization", value: "Qiniu \(Auth.accessToken(signingStr: signingStr))")
        print("===================")
        print("===================")
        print(signingStr)
        print("===================")
        print("===================")
        return request
    }
}

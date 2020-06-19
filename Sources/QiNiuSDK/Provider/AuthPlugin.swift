//
//  AuthPlugin.swift
//  QiNiuSDK
//
//  Created by swifter on 2020/6/16.
//

import Foundation

struct AuthPlugin: PluginType {
    
    func authorization(request: Request) -> String {
        let method = request.method.rawValue
        let path = request.url.path
        var query = request.url.query ?? ""
        query = query.isEmpty ? "" : "?\(query)"
        let host = request.url.host ?? ""
        var contentType = request.headers["Content-Type"].first ?? ""
        contentType = contentType.isEmpty ? "" : "\nContent-Type: \(contentType)"
        let signingStr = "\(method) \(path)\(query)\nHost: \(host)\(contentType)\n\n"
        print("================")
        print(signingStr)
        print("================")
        return "Qiniu \(Auth.accessToken(signingStr: signingStr))"
    }
    
    func prepare(_ request: Request, target: TargetType) -> Request {
        var request = request
        request.headers.add(name: "Authorization", value: authorization(request: request))
        return request
    }
}

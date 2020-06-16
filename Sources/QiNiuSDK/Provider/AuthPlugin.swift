//
//  AuthPlugin.swift
//  QiNiuSDK
//
//  Created by swifter on 2020/6/16.
//

import Foundation

struct AuthPlugin: PluginType {
    
    func authorization(request: Request) -> String {
        return "QBox \(Auth.accessToken(path: "\(request.url.path)\n"))"
    }
    
    func urlAuthorization(request: Request) -> String {
        return "QBox \(Auth.accessToken(path: "\(request.url.path + "?" + (request.url.query ?? ""))\n"))"
    }
    
    func prepare(_ request: Request, target: TargetType) -> Request {
        var request = request
        if let target = Optional(target) as? BucketProvider {
            switch target {
            case .buckets:
                request.headers.add(name: "Authorization", value: authorization(request: request))
            case .bucketSpaceDomainName:
                request.headers.add(name: "Authorization", value: urlAuthorization(request: request))
            default:
                break
            }
        }
        return request
    }
}

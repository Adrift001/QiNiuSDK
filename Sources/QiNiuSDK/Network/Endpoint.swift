//
//  Endpoint.swift
//  QiNiuSDK
//
//  Created by 荆学涛 on 2019/8/18.
//

import Vapor

public class Endpoint {
    /// A string representation of the URL for the request.
    public let url: URI

    /// The HTTP method for the request.
    public let method: HTTPMethod

    /// The `Task` for the request.
    public let task: Task

    /// The HTTP header fields for the request.
    public var httpHeaderFields: [String: String]?
    
    public let body: Data?
        
    public init(url: URI,
                method: HTTPMethod,
                task: Task,
                httpHeaderFields: [String: String]?,
                body: Data?) {
        self.url = url
        self.method = method
        self.task = task
        self.httpHeaderFields = httpHeaderFields
        self.body = body
    }
    
}

extension Endpoint {
    
    func auth(request: inout Request) {
        let method = request.method
        let path = request.url.path
        let query = request.url.query == nil ? "" : "?\(request.url.query ?? "")"
        let host = request.host
        let contentType = request.headers["Content-Type"].first ?? ""
        var signingStr = """
        \(method) \(path)\(query)
        Host: \(host)
        Content-Type: \(contentType)


        """
        if let body = body, let string = String(data: body, encoding: .utf8) {
            signingStr += string
        }
        print("============signingStr============")
        print(signingStr)
        print("============signingStr============")
        request.headers.add(name: "Authorization", value: "Qiniu \(Auth.accessToken(signingStr: signingStr))")
    }
    
    public func urlRequest() throws -> Request {
//        guard let requestURL = URL(string: url) else {
//            throw QiNiuError.requestMapping(url)
//        }
        var headers = HTTPHeaders()
        if let dic = httpHeaderFields {
            for (key, value) in dic {
                headers.add(name: key, value: value)
            }
        }
        let requestURL = URL(string: "")!
        var request = try Request(url: requestURL, method: method, headers: headers, body: nil)
        
        switch task {
        case .requestPlain:
            var request = request
            auth(request: &request)
            return request
        case let .requestParameters(parameters, parameterEncoding):
            var request = try request.encoded(parameters: parameters, parameterEncoding: parameterEncoding)
            auth(request: &request)
            return request
        case let .requestJSONEncodable(encodable):
            var request = try request.encoded(encodable: encodable)
            auth(request: &request)
            return request
        case let .requestCompositeData(bodyData: data, urlParameters: urlParameters):
            request.body = Body.data(data)
            var request = try request.encoded(parameters: urlParameters, parameterEncoding: URLEncoding.queryString)
            auth(request: &request)
            return request
            
        }
    }
}

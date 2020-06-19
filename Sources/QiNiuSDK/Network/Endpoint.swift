//
//  Endpoint.swift
//  QiNiuSDK
//
//  Created by 荆学涛 on 2019/8/18.
//

public class Endpoint {
    /// A string representation of the URL for the request.
    public let url: String

    /// The HTTP method for the request.
    public let method: HTTPMethod

    /// The `Task` for the request.
    public let task: Task

    /// The HTTP header fields for the request.
    public let httpHeaderFields: [String: String]?
    
    public init(url: String,
                method: HTTPMethod,
                task: Task,
                httpHeaderFields: [String: String]?) {
        self.url = url
        self.method = method
        self.task = task
        self.httpHeaderFields = httpHeaderFields
    }
}

extension Endpoint {
    public func urlRequest() throws -> Request {
        guard let requestURL = URL(string: url) else {
            throw QiNiuError.requestMapping(url)
        }
        var headers = HTTPHeaders()
        if let dic = httpHeaderFields {
            for (key, value) in dic {
                headers.add(name: key, value: value)
            }
        }
        var request = try Request(url: requestURL, method: method, headers: headers, body: nil)
        switch task {
        case .requestPlain:
            #warning("Authorization")
//            request.headers.add(name: "Authorization", value: "QBox \(Auth.accessToken(signingStr: "\(request.url.path)\n"))")
            return request
        case let .requestParameters(parameters, parameterEncoding):
            return try request.encoded(parameters: parameters, parameterEncoding: parameterEncoding)
        case let .requestJSONEncodable(encodable):
            return try request.encoded(encodable: encodable)
        case let .requestCompositeData(bodyData: data, urlParameters: urlParameters):
            request.body = Body.data(data)
            return try request.encoded(parameters: urlParameters, parameterEncoding: URLEncoding.queryString)
        }
    }
}

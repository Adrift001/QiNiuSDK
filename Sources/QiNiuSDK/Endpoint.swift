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

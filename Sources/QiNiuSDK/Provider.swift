//
//  Provider.swift
//  QiNiuSDK
//
//  Created by 荆学涛 on 2019/8/18.
//
import AsyncHTTPClient
import NIO

public enum ProviderError: Error {
    case beforeRequest
    case decodeFailure
    case requestFailure
}

extension ProviderError {
    public var localizedDescription: String {
        switch self {
        case .beforeRequest:
            return "还没开始请求呢,就报错!!!"
        case .decodeFailure:
            return "解码失败!!!"
        case .requestFailure:
            return "请求出错!!!"
        }
    }
}

public typealias Completion = ((_ result: Result<HTTPClient.Response, ProviderError>) -> Void)

protocol ProviderType: AnyObject {
    associatedtype Target: TargetType
    func request(_ target: Target) -> EventLoopFuture<HTTPClient.Response>
}

public class Provider<Target: TargetType>: ProviderType {
    
    public let client: HTTPClient
    
    init(client: HTTPClient = Provider.defaultHTTPClient()) {
        self.client = client
    }
    
    @discardableResult
    func request(_ target: Target) -> EventLoopFuture<HTTPClient.Response> {
        var request = try! HTTPClient.Request(url: URL(target: target), method: target.method)
        request.headers.add(name: "Authorization", value: "QBox \(Auth.accessToken(path: "/\(target.path)\n"))")
        request.headers.add(name: "Content-Type", value: "application/x-www-form-urlencoded")
        let task = client.execute(request: request)
        return task
    }
}

public extension Provider {
    final class func defaultHTTPClient() -> HTTPClient {
        return HTTPClient(eventLoopGroupProvider: .shared(MultiThreadedEventLoopGroup(numberOfThreads: 10)))
    }
}

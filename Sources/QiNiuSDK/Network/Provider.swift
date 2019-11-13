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

public typealias Completion = ((_ result: Result<Response, ProviderError>) -> Void)

protocol ProviderType: AnyObject {
    associatedtype Target: TargetType
    func request(_ target: Target) -> EventLoopFuture<Response>
}

public class Provider<Target: TargetType>: ProviderType {
    
    public let client: HTTPClient
    
    init(client: HTTPClient = Provider.defaultHTTPClient()) {
        self.client = client
    }
    
    @discardableResult
    func request(_ target: Target) -> EventLoopFuture<Response> {
        let request = try! Request(target: target)
        let task = client.execute(request: request)
        return task
    }
    
    deinit {
        do {
            try client.syncShutdown()
        } catch {
            QiNiuSDKLogger.default.error("client.syncShutdown error")
        }
    }
}

public extension Provider {
    final class func defaultHTTPClient() -> HTTPClient {
        return HTTPClient(eventLoopGroupProvider: .shared(MultiThreadedEventLoopGroup(numberOfThreads: 10)))
    }
}

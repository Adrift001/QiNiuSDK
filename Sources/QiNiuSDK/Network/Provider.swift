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
    
    public typealias Response = HTTPClient.Response
    
    
    public typealias EndpointClosure = (Target) -> Endpoint
    public typealias RequestResultClosure = (Result<Request, QiNiuError>) -> Void
    public typealias RequestClosure = (Endpoint, @escaping RequestResultClosure) -> Void
    
    public let endpointClosure: EndpointClosure
    public let plugins: [PluginType]
    public let client: HTTPClient
    
    init(endpointClosure: @escaping EndpointClosure = Provider.defaultEndpointMapping, plugins: [PluginType] = [], client: HTTPClient = Provider.defaultHTTPClient()) {
        self.endpointClosure = endpointClosure
        self.plugins = plugins
        self.client = client
    }
    
    open func endpoint(_ token: Target) -> Endpoint {
        return endpointClosure(token)
    }
    
    @discardableResult
    public func request(_ target: Target) -> EventLoopFuture<Response>  {
        let endpoint = self.endpoint(target)
        let request = try! endpoint.urlRequest()
        let preparedRequest = plugins.reduce(request) { (request, plugin) -> Request in
            return plugin.prepare(request, target: target)
        }
        plugins.forEach { $0.willSend(preparedRequest, target: target) }
        let task = client.execute(request: preparedRequest).always { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.plugins.forEach { $0.didReceive(.success(response), target: target) }
            case .failure(let error):
                self?.plugins.forEach { $0.didReceive(.failure(.httpClientError(error)), target: target) }
            }
        }
//            .do { (future) in
//
//            future.whenComplete { (result) in
//                do {
//                    let response = try result.get()
//                    plugins.forEach { $0.didReceive(.success(response), target: target) }
//                } catch {
//
//                }
//            }
//        }
        return task
    }
    
    deinit {
        do {
            try client.syncShutdown()
        } catch {
            print(error)
        }
    }
}

public extension Provider {
    final class func defaultHTTPClient() -> HTTPClient {
        return HTTPClient(eventLoopGroupProvider: .shared(MultiThreadedEventLoopGroup(numberOfThreads: 10)))
    }
    
    final class func defaultEndpointMapping(for target: Target) -> Endpoint {
        return Endpoint(
            url: URL(target: target).absoluteString,
            method: target.method,
            task: target.task,
            httpHeaderFields: target.headers
        )
    }
}

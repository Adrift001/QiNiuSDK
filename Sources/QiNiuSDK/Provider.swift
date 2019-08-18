//
//  Provider.swift
//  QiNiuSDK
//
//  Created by 荆学涛 on 2019/8/18.
//
import AsyncHTTPClient

public enum ProviderError: Error {
    case beforeRequest
}

extension ProviderError {
    public var localizedDescription: String {
        switch self {
        case .beforeRequest:
            return "还没开始请求呢,就报错!!!"
        }
    }
}

public typealias Completion = ((_ result: Result<HTTPClient.Response, ProviderError>) -> Void)

protocol ProviderType: AnyObject {
    associatedtype Target: TargetType
    func request(_ target: Target, completion: Completion)
}

public class Provider<Target: TargetType>: ProviderType {

    public typealias EndpointClosure = (Target) -> Endpoint
    public let client: HTTPClient
    
    init(client: HTTPClient = Provider.defaultHTTPClient()) {
        self.client = client
    }
    
    func request(_ target: Target, completion: (Result<HTTPClient.Response, ProviderError>) -> Void) {
        do {
            let request = try HTTPClient.Request(url: URL(target: target), method: target.method)
            client.execute(request: request).whenComplete { (result) in
                switch result {
                case .success(let response):
                    print("")
                case .failure(let error):
                    print("")
                }
            }
        } catch {
            completion(.failure(.beforeRequest))
        }
    }
}

public extension Provider {
    final class func defaultHTTPClient() -> HTTPClient {
        return HTTPClient(eventLoopGroupProvider: .createNew)
    }
}

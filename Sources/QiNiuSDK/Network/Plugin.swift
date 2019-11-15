import Foundation

/// A Moya Plugin receives callbacks to perform side effects wherever a request is sent or received.
///
/// for example, a plugin may be used to
///     - log network requests
///     - hide and show a network activity indicator
///     - inject additional information into a request
public protocol PluginType {
    /// Called to modify a request before sending.
    func prepare(_ request: Request, target: TargetType) -> Request

    /// Called immediately before a request is sent over the network (or stubbed).
    func willSend(_ request: RequestType, target: TargetType)

    /// Called after a response has been received, but before the MoyaProvider has invoked its completion handler.
    func didReceive(_ result: Result<Response, QiNiuError>, target: TargetType)

    /// Called to modify a result before completion.
    func process(_ result: Result<Response, QiNiuError>, target: TargetType) -> Result<Response, QiNiuError>
}

public extension PluginType {
    func prepare(_ request: Request, target: TargetType) -> Request { return request }
    func willSend(_ request: RequestType, target: TargetType) { }
    func didReceive(_ result: Result<Response, QiNiuError>, target: TargetType) { }
    func process(_ result: Result<Response, QiNiuError>, target: TargetType) -> Result<Response, QiNiuError> { return result }
}

/// Request type used by `willSend` plugin function.
public protocol RequestType {

    // Note:
    //
    // We use this protocol instead of the Alamofire request to avoid leaking that abstraction.
    // A plugin should not know about Alamofire at all.

    /// Retrieve an `NSURLRequest` representation.
    var request: Request? { get }
}

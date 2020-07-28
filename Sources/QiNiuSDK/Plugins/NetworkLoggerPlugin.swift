import Foundation


/// Logs network activity (outgoing requests and incoming responses).
public final class NetworkLoggerPlugin: PluginType {
    
    fileprivate let loggerId = "QiNiuSDK_Logger"
    fileprivate let dateFormatString = "dd/MM/yyyy HH:mm:ss"
    fileprivate let dateFormatter = DateFormatter()
    fileprivate let separator = ", "
    fileprivate let terminator = "\n"
    fileprivate let cURLTerminator = "\\\n"
    fileprivate let output: (_ separator: String, _ terminator: String, _ items: Any...) -> Void
    fileprivate let requestDataFormatter: ((Data) -> (String))?
    fileprivate let responseDataFormatter: ((Data) -> (Data))?

    /// A Boolean value determing whether response body data should be logged.
    public let isVerbose: Bool
    public let cURL: Bool

    /// Initializes a NetworkLoggerPlugin.
    public init(verbose: Bool = false, cURL: Bool = false, output: ((_ separator: String, _ terminator: String, _ items: Any...) -> Void)? = nil, requestDataFormatter: ((Data) -> (String))? = nil, responseDataFormatter: ((Data) -> (Data))? = nil) {
        self.cURL = cURL
        self.isVerbose = verbose
        self.output = output ?? NetworkLoggerPlugin.reversedPrint
        self.requestDataFormatter = requestDataFormatter
        self.responseDataFormatter = responseDataFormatter
    }

    public func willSend(_ request: RequestType, target: TargetType) {
        outputItems(logNetworkRequest(request as? Request))
    }

    public func didReceive(_ result: Result<Response, QiNiuError>, target: TargetType) {
        if case .success(let response) = result {
            if var body = response.body, let bytes = body.readBytes(length: body.readableBytes) {
                let data = Data(bytes: bytes, count: bytes.count)
                outputItems(logNetworkResponse(response, data: data, target: target))
            }
            
        } else {
            outputItems(logNetworkResponse(nil, data: nil, target: target))
        }
    }

    fileprivate func outputItems(_ items: [String]) {
        if isVerbose {
            items.forEach { output(separator, terminator, $0) }
        } else {
            output(separator, terminator, items)
        }
    }
}

private extension NetworkLoggerPlugin {

    var date: String {
        dateFormatter.dateFormat = dateFormatString
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: Date())
    }

    func format(_ loggerId: String, date: String, identifier: String, message: String) -> String {
        return "\(loggerId): [\(date)] \(identifier): \(message)"
    }

    func logNetworkRequest(_ request: Request?) -> [String] {

        var output = [String]()
        
        output += [format(loggerId, date: date, identifier: "Request URL", message: request?.url.absoluteString ?? "")]

        if let headers = request?.headers {
            output += [format(loggerId, date: date, identifier: "Request Headers", message: headers.description)]
        }

        if let httpMethod = request?.method {
            output += [format(loggerId, date: date, identifier: "Request Method", message: httpMethod.rawValue)]
        }
        
        if let body = request?.body, isVerbose {
            output += [format(loggerId, date: date, identifier: "Request Body", message: "\(body)")]
        }

        return output
    }

    func logNetworkResponse(_ response: Response?, data: Data?, target: TargetType) -> [String] {
        guard let response = response else {
           return [format(loggerId, date: date, identifier: "Response", message: "Received empty network response for \(target).")]
        }

        var output = [String]()
        
        output += [format(loggerId, date: date, identifier: "Response StatusCode", message: "\(response.status.code)")]

        if let data = data, let stringData = String(data: responseDataFormatter?(data) ?? data, encoding: String.Encoding.utf8), isVerbose {
            output += [format(loggerId, date: date, identifier: "Response Body", message: "\(stringData)")]
        }

        return output
    }
}

fileprivate extension NetworkLoggerPlugin {
    static func reversedPrint(_ separator: String, terminator: String, items: Any...) {
        for item in items {
            print(item, separator: separator, terminator: terminator)
        }
    }
}

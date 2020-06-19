//
//  ParameterEncoding.swift
//  QiNiuSDK
//
//  Created by 荆学涛 on 2019/11/15.
//

/// A dictionary of parameters to apply to a `URLRequest`.
public typealias Parameters = [String: Any]

/// A type used to define how a set of parameters are applied to a `URLRequest`.
public protocol ParameterEncoding {
    /// Creates a URL request by encoding parameters and applying them onto an existing request.
    ///
    /// - parameter urlRequest: The request to have parameters applied.
    /// - parameter parameters: The parameters to apply.
    ///
    /// - throws: An `AFError.parameterEncodingFailed` error if encoding fails.
    ///
    /// - returns: The encoded request.
    func encode(_ urlRequest: Request, with parameters: Parameters?) throws -> Request
}

public struct URLEncoding: ParameterEncoding {
    
    public enum ArrayEncoding {
        case brackets, noBrackets

        func encode(key: String) -> String {
            switch self {
            case .brackets:
                return "\(key)[]"
            case .noBrackets:
                return key
            }
        }
    }
    
    public static var queryString: URLEncoding { return URLEncoding() }
    
    public let arrayEncoding = ArrayEncoding.brackets
    
    public func encode(_ urlRequest: Request, with parameters: Parameters?) throws -> Request {
        guard let parameters = parameters else { return urlRequest }
        if var urlComponents = URLComponents(url: urlRequest.url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            let percentEncodedQuery = (urlComponents.percentEncodedQuery.map { $0 + "&" } ?? "") + query(parameters)
            urlComponents.percentEncodedQuery = percentEncodedQuery
            if let url = urlComponents.url {
                let request = try Request(url: url, method: urlRequest.method, headers: urlRequest.headers, body: urlRequest.body)
                return request
            } else {
                throw QiNiuError.missingURL
            }
        } else {
            throw QiNiuError.missingURL
        }
    }
    
    private func query(_ parameters: [String: Any]) -> String {
        var components: [(String, String)] = []

        for key in parameters.keys.sorted(by: <) {
            let value = parameters[key]!
            components += queryComponents(fromKey: key, value: value)
        }
        return components.map { "\($0)=\($1)" }.joined(separator: "&")
    }
    
    public func queryComponents(fromKey key: String, value: Any) -> [(String, String)] {
        var components: [(String, String)] = []

        if let dictionary = value as? [String: Any] {
            for (nestedKey, value) in dictionary {
                components += queryComponents(fromKey: "\(key)[\(nestedKey)]", value: value)
            }
        } else if let array = value as? [Any] {
            for value in array {
                components += queryComponents(fromKey: arrayEncoding.encode(key: key), value: value)
            }
        } else {
            components.append((escape(key), escape("\(value)")))
        }

        return components
    }
    
    public func escape(_ string: String) -> String {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowedCharacterSet = CharacterSet.urlQueryAllowed
        allowedCharacterSet.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")

        var escaped = ""

        let batchSize = 50
        var index = string.startIndex

        while index != string.endIndex {
            let startIndex = index
            let endIndex = string.index(index, offsetBy: batchSize, limitedBy: string.endIndex) ?? string.endIndex
            let range = startIndex..<endIndex

            let substring = string[range]

            escaped += substring.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? String(substring)

            index = endIndex
        }

        return escaped
    }
}

public struct JSONEncoding: ParameterEncoding {
    
    /// The options for writing the parameters as JSON data.
    public let options: JSONSerialization.WritingOptions

    // MARK: Initialization

    /// Creates a `JSONEncoding` instance using the specified options.
    ///
    /// - parameter options: The options for writing the parameters as JSON data.
    ///
    /// - returns: The new `JSONEncoding` instance.
    public init(options: JSONSerialization.WritingOptions = []) {
        self.options = options
    }
    
    public static var `default`: JSONEncoding { return JSONEncoding() }
    
    public func encode(_ urlRequest: Request, with parameters: Parameters?) throws -> Request {
        guard let parameters = parameters else { return urlRequest }

        do {
            let data = try JSONSerialization.data(withJSONObject: parameters, options: options)

            var request = try Request(url: urlRequest.url, method: urlRequest.method, headers: urlRequest.headers, body: Body.data(data))
            if !request.headers.contains(name: "Content-Type") {
                request.headers.add(name: "Content-Type", value: "application/json")
            }
            return request
        } catch {
            throw QiNiuError.jsonEncodingFailed(error: error)
        }
    }
}

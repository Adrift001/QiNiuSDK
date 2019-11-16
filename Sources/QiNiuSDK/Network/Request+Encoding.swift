//
//  Request+Encoding.swift
//  QiNiuSDK
//
//  Created by 荆学涛 on 2019/11/15.
//

public extension Request {
    
    func encoded(parameters: [String: Any], parameterEncoding: ParameterEncoding) throws -> Request {
        do {
            return try parameterEncoding.encode(self, with: parameters)
        } catch {
            throw QiNiuError.parameterEncoding(error)
        }
    }
    
    func encoded(encodable: Encodable, encoder: JSONEncoder = JSONEncoder()) throws -> Request {
        do {
            let encodable = AnyEncodable(encodable)
            let data = try encoder.encode(encodable)
            QiNiuSDKLogger.default.info("\(String(data: data, encoding: .utf8) ?? "")")
            let url =  URL(string: self.url.absoluteString.removingPercentEncoding ?? "")
            QiNiuSDKLogger.default.info("\(url!.absoluteURL)")
            var request = try Request(url: url!, method: method, headers: headers, body: Body.data(data))
            request.headers.add(name: "Authorization", value: "QBox \(Auth.accessToken(path: "\(url!.path + "?" + (url!.query ?? ""))\n"))")
            return request
        } catch {
            throw QiNiuError.encodableMapping(error)
        }
    }
}

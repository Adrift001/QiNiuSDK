//
//  Request+TargetType.swift
//  QiNiuSDK
//
//  Created by 荆学涛 on 2019/11/12.
//


public extension Request {
    
    init(target: TargetType) throws {
        var headers = HTTPHeaders()
        if let dic = target.headers {
            for (key, value) in dic {
                headers.add(name: key, value: value)
            }
            QiNiuSDKLogger.default.log(level: .info, "\(headers.description)")
        }
        var path = ""
        switch target.task {
        case .requestPlain:
            let url = URL(target: target)
            path = target.path
            QiNiuSDKLogger.default.info("\(url.absoluteString)")
            try self.init(url: url, method: target.method, headers: headers)
        case .requestParameters(let parameters, let encoding):
            switch encoding {
            case .json:
                let body = Body.string(parameters.toJSONString())
                let url = URL(target: target)
                path = target.path
                QiNiuSDKLogger.default.info("\(url.absoluteString)")
                try self.init(url: url, method: target.method, headers: headers, body: body)
            case .queryString:
                var urlString = "\(target.baseURL.absoluteString)\(target.path)?"
                var queryString = ""
                for parameter in parameters {
                    queryString += "\(parameter.key)=\(parameter.value)"
                }
                urlString += queryString
                let url = URL(string: urlString)!
                path = target.path + "?" + queryString
                QiNiuSDKLogger.default.info("\(url.absoluteString)")
                try self.init(url: url, method: target.method, headers: headers)
            }
        }
        print("=======================")
        print("=======================")
        print(path)
        print("=======================")
        print("=======================")
//        "Authorization": "QBox \(Auth.accessToken(path: "/\(path)\n"))",
        self.headers.add(name: "Authorization", value: "QBox \(Auth.accessToken(path: "/\(path)\n"))")
    }
}

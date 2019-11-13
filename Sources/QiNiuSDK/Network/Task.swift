//
//  Task.swift
//  QiNiuSDK
//
//  Created by 荆学涛 on 2019/8/17.
//
//  From Moya: https://github.com/Moya/Moya/blob/master/Sources/Moya/Task.swift
import Foundation

public enum Encoding {
    case queryString
    case json
}

/// Represents an HTTP task.
public enum Task {

    /// A request with no additional data.
    case requestPlain

    /// A requests body set with encoded parameters.
    case requestParameters(parameters: [String: Any], encoding: Encoding)
}

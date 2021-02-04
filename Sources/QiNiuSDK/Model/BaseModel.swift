//
//  File.swift
//  
//
//  Created by swifter on 2021/2/4.
//

import Foundation

public struct ResponseModel<T: Codable> :Codable {
    
    /// 七牛返回的statusCode
    var code: UInt
    var error: String?
    var errorCode: String?
    var data: T?
}

public extension ResponseModel {
    func toString() -> String {
        let encoder = JSONEncoder()
        do {
            let string = try String(data: encoder.encode(self), encoding: .utf8) ?? ""
            return string
        } catch {
            return ""
        }
    }
}

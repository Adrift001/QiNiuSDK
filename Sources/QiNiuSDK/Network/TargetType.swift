//
//  TargetType.swift
//  QiNiuSDK
//
//  Created by 荆学涛 on 2019/8/17.
//

import Foundation
import NIOHTTP1
import NIO

public protocol TargetType {
    var baseURL: URL { get }
    
    var path: String { get }
    
    var method: HTTPMethod { get }
    
    var task: Task { get }
    
    var headers: [String: String]? { get }
    
    var body: Data? { get }
}

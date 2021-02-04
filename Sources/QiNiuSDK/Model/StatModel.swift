//
//  File.swift
//  
//
//  Created by swifter on 2021/2/5.
//

import Foundation

public struct StatModel: Codable {
    var fsize: UInt64
    var hash: String
    var md5: String
    var mimeType: String
    var putTime: UInt64
    var type: UInt32
}

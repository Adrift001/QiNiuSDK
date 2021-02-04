//
//  File.swift
//  
//
//  Created by swifter on 2020/7/1.
//

import Foundation

public enum BatchOperationType: String {
    case stat
    case copy
    case move
    case delete
    case restoreAr
}

public struct BatchModel {
    var type = BatchOperationType.stat
    var bucketName = ""
    var fileName = ""
    var fromBucketName = ""
    var fromFileName = ""
    var toBucketName = ""
    var toFileName = ""
    var force = false
}

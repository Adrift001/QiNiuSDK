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
    
    public init(type: BatchOperationType, bucketName: String, fileName: String) {
        self.type = type
        self.bucketName = bucketName
        self.fileName = fileName
    }
    
    public init(type: BatchOperationType, fromBucketName: String, fromFileName: String, toBucketName: String, toFileName: String, force: Bool = true) {
        self.type = type
        self.fromBucketName = fromBucketName
        self.fromFileName = fromFileName
        self.toBucketName = toBucketName
        self.toFileName = toFileName
        self.force = force
    }
}

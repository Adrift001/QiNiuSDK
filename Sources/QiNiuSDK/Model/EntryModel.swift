//
//  File.swift
//  
//
//  Created by swifter on 2020/6/22.
//

import Foundation

public struct EntryModel: Codable {
    
    private let bucketName: String
    private let fileName: String
    
    public init(bucketName: String, fileName: String) {
        self.bucketName = bucketName
        self.fileName = fileName
    }
    
    private var entry: String {
        return "\(bucketName):\(fileName)"
    }
    
    var encodedEntryURI: String {
        return Base64FS.encodeString(str: entry)
    }
}

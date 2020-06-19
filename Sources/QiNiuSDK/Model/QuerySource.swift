//
//  QuerySource.swift
//  QiNiuSDK
//
//  Created by swifter on 2019/11/19.
//

public struct QuerySource: Codable {
    var marker: String
    var items: [QuerySourceItem]
}

public struct QuerySourceItem: Codable {
    var key: String
    var hash: String
    var fsize: Int
    var mimeType: String
    var putTime: UInt64
    var type: Int
    var status: Int
}

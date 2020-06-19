//
//  BucketTagModel.swift
//  QiNiuSDK
//
//  Created by 荆学涛 on 2019/11/15.
//

public struct BucketTagsModel: Codable {
    var Tags: [BucketTagModel]
}

public struct BucketTagModel: Codable {
    var Key = ""
    var Value = ""
}

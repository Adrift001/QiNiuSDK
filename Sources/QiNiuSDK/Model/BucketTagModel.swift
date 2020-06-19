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
    let Key: String
    let Value: String
}

//
//  BucketTagModel.swift
//  QiNiuSDK
//
//  Created by 荆学涛 on 2019/11/15.
//

public struct BucketTagsModel: Codable {
    var Tags: [BucketTagModel]
    init(Tags: [BucketTagModel]) {
        self.Tags = Tags
    }
}

public struct BucketTagModel: Codable {
    let Key: String
    let Value: String
    init(Key: String, Value: String) {
        self.Key = Key
        self.Value = Value
    }
}

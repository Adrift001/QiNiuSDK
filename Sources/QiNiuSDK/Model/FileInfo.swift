//
//  FileInfo.swift
//  QiNiuSDK
//
//  Created by 荆学涛 on 2019/11/18.
//


public struct FileInfo: Codable {
    var fsize: Int
    var hash: String
    var mimeType: String
    var type: Int
    var putTime: Int
}

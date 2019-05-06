//
//  UploadStrategy.swift
//  QiNiuSDK
//
//  Created by 荆学涛 on 2019/5/6.
//

import Foundation

class UploadStrategy: Codable {
    var scope = "blog-pic"
    var deadline: UInt = UInt(Date(timeIntervalSinceNow: 3600).timeIntervalSince1970)
}

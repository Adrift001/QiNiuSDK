//
//  File.swift
//  
//
//  Created by swifter on 2020/7/31.
//

import Vapor

public extension Application {
    
    var qiniu: QiNiuSDK {
        .init(application: self)
    }
}

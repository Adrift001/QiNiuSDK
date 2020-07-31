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
    
    struct QiNiuSDK {
        public let application: Application
        
         func test() throws {
            let res = try application.client.get("https://www.baidu.com").wait()
            print(res)
        }
    }
    
}

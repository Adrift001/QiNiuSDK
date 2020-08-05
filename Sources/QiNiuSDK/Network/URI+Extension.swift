//
//  URL+Extension.swift
//  QiNiuSDK
//
//  Created by 荆学涛 on 2019/8/18.
//

import Foundation

public extension URI {
    
    init(target: TargetType) {
        if target.path.isEmpty {
            self = target.baseURL
        } else {
            self = target.baseURL.appendingPathComponent(target.path)
        }
    }
    
    func appendingPathComponent(_ path: String) -> URI {
        print("==========appendingPathComponent=============")
        print(self.string)
        print(path)
        print("==========appendingPathComponent=============")
        return URI(path: "\(self.string)\(path)")
    }
}

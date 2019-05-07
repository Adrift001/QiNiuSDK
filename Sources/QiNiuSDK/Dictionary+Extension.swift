//
//  Dictionary+Extension.swift
//  QiNiuSDK
//
//  Created by 荆学涛 on 2019/5/6.
//

extension Dictionary {
    func toJSONString() -> String {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: []) else {
            return ""
        }
        return String(data: data, encoding: .utf8) ?? ""
    }
}

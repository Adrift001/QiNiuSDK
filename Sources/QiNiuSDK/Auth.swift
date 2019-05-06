//
//  Auth.swift
//  QiNiuSDK
//
//  Created by 荆学涛 on 2019/5/6.
//

import Foundation
import CryptoSwift

public class Auth {

    /// 创建上传凭证
    ///
    /// - Returns: 上传凭证
    public static func createToken() -> String {
        let uploadStrategy = UploadStrategy()
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(uploadStrategy)
            guard let putPolicy = String(data: data, encoding: .utf8) else { return "" }
            
            let encodedPutPolicy = Base64FS.encodeString(str: putPolicy)
            
            // 参考:http://m.hangge.com/news/cache/detail_1867.html
            let sign = try HMAC(key: QiNiuSDK.secretKey.bytes, variant: .sha1).authenticate(encodedPutPolicy.bytes)
            
            let encodedSign = String(bytes: Base64FS.encode(data: sign), encoding: .utf8) ?? ""
            
            let uploadToken = "\(QiNiuSDK.accessKey):\(encodedSign):\(encodedPutPolicy)"
            return uploadToken
        } catch {
            print(error)
        }
        return ""
    }
}

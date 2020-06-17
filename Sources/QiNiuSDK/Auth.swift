//
//  Auth.swift
//  QiNiuSDK
//
//  Created by 荆学涛 on 2019/5/6.
//

import CryptoSwift

public final class Auth {
    
    /// 上传策略, 参考: https://developer.qiniu.com/kodo/manual/put-policy
    private static let policyFields = [
        "callbackUrl",
        "callbackBody",
        "callbackHost",
        "callbackBodyType",
        "callbackFetchKey",
        
        "returnUrl",
        "returnBody",
        
        "endUser",
        "saveKey",
        "insertOnly",
        "isPrefixalScope",
        
        "detectMime",
        "mimeLimit",
        "fsizeLimit",
        "fsizeMin",
        
        "persistentOps",
        "persistentNotifyUrl",
        "persistentPipeline",
        
        "deleteAfterDays",
        "fileType",
    ]
    
    private static let deprecatedPolicyFields = [
        "asyncOps",
    ]
    
    private let accessKey: String
    private let secretKey: String
    
    init(accessKey: String, secretKey: String) {
        self.accessKey = accessKey
        self.secretKey = secretKey
    }
    
    public static func create() -> Auth {
        guard !Keys.accessKey.isEmpty && !Keys.secretKey.isEmpty else {
            fatalError("`accessKey` or `secretKey` is empty")
        }
        return Auth(accessKey: Keys.accessKey, secretKey: Keys.secretKey)
    }
    
    private static func copyPolicy(policy: inout [String: Any], originPolicy: [String: Any], strict: Bool) {
        if originPolicy.isEmpty {
            return
        }
        originPolicy.forEach { (key, value) in
            if deprecatedPolicyFields.contains(key) {
                fatalError("`\(key)` is deprecated!")
            }
            if !strict || policyFields.contains(key) {
                policy[key] = value
            }
        }
    }
    
    /// 生成上传token
    /// - Parameter bucket: 空间名
    /// - Parameter key: key，可为 null
    /// - Parameter expires: 有效时长，单位秒。默认3600s
    /// - Parameter policy: 上传策略的其它参数，如 new StringMap().put("endUser", "uid").putNotEmpty("returnBody", "")。scope通过 bucket、key间接设置，deadline 通过 expires 间接设置
    /// - Parameter strict: 是否去除非限定的策略字段，默认true
    public func uploadToken(bucket: String, key: String = "", expires: UInt = 3600, policy: [String: Any] = [:], strict: Bool = true) -> String {
        let deadline = Date(timeIntervalSinceNow: Double(expires)).timeIntervalSince1970
        return uploadTokenWithDeadline(bucket: bucket, key: key, deadline: UInt(deadline), policy: policy, strict: strict)
    }
    
    public func uploadTokenWithDeadline(bucket: String, key: String, deadline: UInt, policy: [String: Any], strict: Bool) -> String {
        guard !bucket.isEmpty else {
            fatalError("`bucket` is empty")
        }
        var scope = bucket
        if !key.isEmpty {
            scope = scope + ":" + key
        }
        var x: [String: Any] = [:]
        Auth.copyPolicy(policy: &x, originPolicy: policy, strict: strict)
        x["scope"] = scope
        x["deadline"] = deadline
        
        let encodedPutPolicy = Base64FS.encodeString(str: x.toJSONString())
        do {
            // 参考:http://m.hangge.com/news/cache/detail_1867.html
            let sign = try HMAC(key: secretKey.bytes, variant: .sha1).authenticate(encodedPutPolicy.bytes)
            
            let encodedSign = String(bytes: Base64FS.encode(data: sign), encoding: .utf8) ?? ""
            return encodedSign
        } catch {
            return ""
        }
    }
    
    public static func accessToken(signingStr: String) -> String  {
        do {
            let sign = try HMAC(key: Keys.secretKey.bytes, variant: .sha1).authenticate(signingStr.bytes)
            
            let encodedSign = String(bytes: Base64FS.encode(data: Array(sign.toHexString().utf8)), encoding: .utf8) ?? ""
            let accessToken = "\(Keys.accessKey):\(encodedSign)"
            return accessToken
        } catch {
            return ""
        }
    }
}

//
//  Auth.swift
//  QiNiuSDK
//
//  Created by 荆学涛 on 2019/5/6.
//

import Foundation
import CryptoSwift

public final class Auth {
    
    /**
     * 上传策略
     * 参考文档：<a href="https://developer.qiniu.com/kodo/manual/put-policy">上传策略</a>
     */
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
    
    static func create(accessKey: String, secretKey: String) -> Auth {
        guard !accessKey.isEmpty && !secretKey.isEmpty else {
            fatalError("`accessKey` or `secretKey` is empty")
        }
        return Auth(accessKey: accessKey, secretKey: secretKey)
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
    
    /**
     * scope = bucket
     * 一般情况下可通过此方法获取token
     *
     * @param bucket 空间名
     * @return 生成的上传token
     */
    func uploadToken(bucket: String) -> String {
        return uploadToken(bucket: bucket, key: "", expires: 3600, policy: [:], strict: true)
    }
    
    /**
     * scope = bucket:key
     * 同名文件覆盖操作、只能上传指定key的文件可以可通过此方法获取token
     *
     * @param bucket 空间名
     * @param key    key，可为 null
     * @return 生成的上传token
     */
    func uploadToken(bucket: String, key: String) -> String {
        return uploadToken(bucket: bucket, key: key, expires: 3600, policy: [:], strict: true)
    }
    
    /**
     * 生成上传token
     *
     * @param bucket  空间名
     * @param key     key，可为 null
     * @param expires 有效时长，单位秒
     * @param policy  上传策略的其它参数，如 new StringMap().put("endUser", "uid").putNotEmpty("returnBody", "")。
     *                scope通过 bucket、key间接设置，deadline 通过 expires 间接设置
     * @return 生成的上传token
     */
    func uploadToken(bucket: String, key: String, expires: UInt, policy: [String: Any]) -> String {
        return uploadToken(bucket: bucket, key: key, expires: expires, policy: policy, strict: true)
    }
    
    /**
     * 生成上传token
     *
     * @param bucket  空间名
     * @param key     key，可为 null
     * @param expires 有效时长，单位秒。默认3600s
     * @param policy  上传策略的其它参数，如 new StringMap().put("endUser", "uid").putNotEmpty("returnBody", "")。
     *                scope通过 bucket、key间接设置，deadline 通过 expires 间接设置
     * @param strict  是否去除非限定的策略字段，默认true
     * @return 生成的上传token
     */
    public func uploadToken(bucket: String, key: String, expires: UInt, policy: [String: Any], strict: Bool) -> String {
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
            
            let uploadToken = "\(accessKey):\(encodedSign):\(encodedPutPolicy)"
            return uploadToken
        } catch {
            return ""
        }
    }
}

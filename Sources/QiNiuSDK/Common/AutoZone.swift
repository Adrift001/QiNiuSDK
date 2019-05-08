//
//  AutoZone.swift
//  QiNiuSDK
//
//  Created by 荆学涛 on 2019/5/8.
//

public final class AutoZone: Zone {
    public static let instance = AutoZone()
    private let ucServer: String = ""
    private let zones: [ZoneIndex: ZoneInfo] = [:]
    
    class UCRet {
        var http: Dictionary<String, [String]> = [:]
        var https: Dictionary<String, [String]> = [:]
    }
    
    struct ZoneIndex: Hashable {
        let accessKey: String
        let bucket: String
        
        init(accessKey: String, bucket: String) {
            self.accessKey = accessKey
            self.bucket = bucket
        }
    }
    
    class ZoneInfo {
        var upHttp: String
        var upBackupHttp: String
        var upIpHttp: String
        var iovipHttp: String
        var upHttps: String
        var upBackupHttps: String
        var upIpHttps: String
        var iovipHttps: String
        
        init(upHttp: String, upBackupHttp: String, upIpHttp: String, iovipHttp: String, upHttps: String, upBackupHttps: String, upIpHttps: String, iovipHttps: String) {
            self.upHttp = upHttp
            self.upBackupHttp = upBackupHttp
            self.upIpHttp = upIpHttp
            self.iovipHttp = iovipHttp
            self.upHttps = upHttps
            self.upBackupHttps = upBackupHttps
            self.upIpHttps = upIpHttps
            self.iovipHttps = iovipHttps
        }
        
        static func buildFromUcRet(ret: UCRet) -> ZoneInfo {
            
            if let upsHttp = ret.http["up"] {
                print(upsHttp) //TODO
            }
            
            return ZoneInfo(upHttp: "", upBackupHttp: "", upIpHttp: "", iovipHttp: "", upHttps: "", upBackupHttps: "", upIpHttps: "", iovipHttps: "")
        }
    }
}

extension AutoZone.ZoneIndex: Equatable {
    static func == (lhs: AutoZone.ZoneIndex, rhs: AutoZone.ZoneIndex) -> Bool {
        return lhs.accessKey == rhs.accessKey && lhs.bucket == rhs.bucket
    }
}



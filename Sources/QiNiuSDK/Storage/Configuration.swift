//
//  Configuration.swift
//  QiNiuSDK
//
//  Created by 荆学涛 on 2019/5/8.
//

public struct Configuration {
    public let zone: Zone?
    public let useHttpsDomains = false
    public let putThreshold = 4194304
    public let connectTimeout = 10
    public let writeTimeout = 0
    public let readTimeout = 30
    public let dispatcherMaxRequests = 64
    public let dispatcherMaxRequestsPerHost = 16
    public let connectionPoolMaxIdleCount = 32
    public let connectionPoolMaxIdleMinutes = 5
    public let retryMax = 5
    public let defaultRsHost = "rs.qiniu.com"
    public let defaultApiHost = "api.qiniu.com"
    
    public init(zone: Zone) {
        self.zone = zone
    }
    
    
}

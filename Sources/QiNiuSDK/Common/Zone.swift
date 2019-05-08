//
//  Zone.swift
//  QiNiuSDK
//
//  Created by 荆学涛 on 2019/5/8.
//

public class Zone {
    private var upHttp: String = ""
    private var upHttps: String = ""
    private var upBackupHttp: String = ""
    private var upBackupHttps: String = ""
    private var upIpHttp: String = ""
    private var upIpHttps: String = ""
    private var iovipHttp: String = ""
    private var iovipHttps: String = ""
    private var rsHttp = "http://rs.qiniu.com"
    private var rsHttps = "https://rs.qbox.me"
    private var rsfHttp = "http://rsf.qiniu.com"
    private var rsfHttps = "https://rsf.qbox.me"
    private var apiHttp = "http://api.qiniu.com"
    private var apiHttps = "https://api.qiniu.com"
    
    public class Builder {
        private let zone: Zone
        public init() {
            self.zone = Zone()
        }
        
        public convenience init(originZone: Zone) {
            self.init()
            self.zone.upHttp = originZone.upHttp
            self.zone.upHttps = originZone.upHttps
            self.zone.upBackupHttp = originZone.upBackupHttp
            self.zone.upBackupHttps = originZone.upBackupHttps
            self.zone.upIpHttp = originZone.upIpHttp
            self.zone.upIpHttps = originZone.upIpHttps
            self.zone.iovipHttp = originZone.iovipHttp
            self.zone.iovipHttps = originZone.iovipHttps
            self.zone.rsHttp = originZone.rsHttp
            self.zone.rsHttps = originZone.rsHttps
            self.zone.rsfHttp = originZone.rsfHttp
            self.zone.rsfHttps = originZone.rsfHttps
            self.zone.apiHttp = originZone.apiHttp
            self.zone.apiHttps = originZone.apiHttps
            
        }
        
        public func upHttp(upHttp: String) -> Builder {
            self.zone.upHttp = upHttp
            return self
        }
        public func upBackupHttp(upBackupHttp: String) -> Builder {
            self.zone.upBackupHttp = upBackupHttp
            return self
        }
        public func upHttps(upHttps: String) -> Builder {
            self.zone.upHttps = upHttps
            return self
        }
        public func upBackupHttps(upBackupHttps: String) -> Builder {
            self.zone.upBackupHttps = upBackupHttps
            return self
        }
        public func upIpHttp(upIpHttp: String) -> Builder {
            self.zone.upIpHttp = upIpHttp
            return self
        }
        public func upIpHttps(upIpHttps: String) -> Builder {
            self.zone.upIpHttps = upIpHttps
            return self
        }
        public func iovipHttp(iovipHttp: String) -> Builder {
            self.zone.iovipHttp = iovipHttp
            return self
        }
        public func iovipHttps(iovipHttps: String) -> Builder {
            self.zone.iovipHttps = iovipHttps
            return self
        }
        public func rsHttp(rsHttp: String) -> Builder {
            self.zone.rsHttp = rsHttp
            return self
        }
        public func rsHttps(rsHttps: String) -> Builder {
            self.zone.rsHttps = rsHttps
            return self
        }
        public func rsfHttp(rsfHttp: String) -> Builder {
            self.zone.rsfHttp = rsfHttp
            return self
        }
        public func rsfHttps(rsfHttps: String) -> Builder {
            self.zone.rsfHttps = rsfHttps
            return self
        }
        
        public func apiHttp(apiHttp: String) -> Builder {
            self.zone.apiHttp = apiHttp
            return self
        }
        
        public func apiHttps(apiHttps: String) -> Builder {
            self.zone.apiHttps = apiHttps
            return self
        }
    }
}

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
    
    public static func zone0() -> Zone {
        return Builder().upHttp("http://up.qiniu.com").upHttps("https://up.qbox.me").upBackupHttp("http://upload.qiniu.com").upBackupHttps("https://upload.qbox.me").iovipHttp("http://iovip.qbox.me").iovipHttps("https://iovip.qbox.me").rsHttp("http://rs.qiniu.com").rsHttps("https://rs.qbox.me").rsfHttp("http://rsf.qiniu.com").rsfHttps("https://rsf.qbox.me").apiHttp("http://api.qiniu.com").apiHttps("https://api.qiniu.com").build();
    }
    
    public static func huadong() -> Zone {
        return zone0()
    }
    
    public static func zone1() -> Zone {
    return Builder().upHttp("http://up-z1.qiniu.com").upHttps("https://up-z1.qbox.me").upBackupHttp("http://upload-z1.qiniu.com").upBackupHttps("https://upload-z1.qbox.me").iovipHttp("http://iovip-z1.qbox.me").iovipHttps("https://iovip-z1.qbox.me").rsHttp("http://rs-z1.qiniu.com").rsHttps("https://rs-z1.qbox.me").rsfHttp("http://rsf-z1.qiniu.com").rsfHttps("https://rsf-z1.qbox.me").apiHttp("http://api-z1.qiniu.com").apiHttps("https://api-z1.qiniu.com").build();
    }
    
    public static func huabei() -> Zone {
        return zone1()
    }
    
    public static func zone2() -> Zone {
    return Builder().upHttp("http://up-z2.qiniu.com").upHttps("https://up-z2.qbox.me").upBackupHttp("http://upload-z2.qiniu.com").upBackupHttps("https://upload-z2.qbox.me").iovipHttp("http://iovip-z2.qbox.me").iovipHttps("https://iovip-z2.qbox.me").rsHttp("http://rs-z2.qiniu.com").rsHttps("https://rs-z2.qbox.me").rsfHttp("http://rsf-z2.qiniu.com").rsfHttps("https://rsf-z2.qbox.me").apiHttp("http://api-z2.qiniu.com").apiHttps("https://api-z2.qiniu.com").build();
    }
    
    public static func huanan() -> Zone {
        return zone2()
    }
    
    public static func zoneNa0() -> Zone {
    return Builder().upHttp("http://up-na0.qiniu.com").upHttps("https://up-na0.qbox.me").upBackupHttp("http://upload-na0.qiniu.com").upBackupHttps("https://upload-na0.qbox.me").iovipHttp("http://iovip-na0.qbox.me").iovipHttps("https://iovip-na0.qbox.me").rsHttp("http://rs-na0.qiniu.com").rsHttps("https://rs-na0.qbox.me").rsfHttp("http://rsf-na0.qiniu.com").rsfHttps("https://rsf-na0.qbox.me").apiHttp("http://api-na0.qiniu.com").apiHttps("https://api-na0.qiniu.com").build();
    }
    
    public static func beimei() -> Zone {
        return zoneNa0()
    }
    
    public static func zoneAs0() -> Zone {
    return Builder().upHttp("http://up-as0.qiniu.com").upHttps("https://up-as0.qbox.me").upBackupHttp("http://upload-as0.qiniu.com").upBackupHttps("https://upload-as0.qbox.me").iovipHttp("http://iovip-as0.qbox.me").iovipHttps("https://iovip-as0.qbox.me").rsHttp("http://rs-as0.qiniu.com").rsHttps("https://rs-as0.qbox.me").rsfHttp("http://rsf-as0.qiniu.com").rsfHttps("https://rsf-as0.qbox.me").apiHttp("http://api-as0.qiniu.com").apiHttps("https://api-as0.qiniu.com").build();
    }
    
    public static func xinjiapo() -> Zone {
        return zoneAs0()
    }
    
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
        
        public func upHttp(_ upHttp: String) -> Builder {
            self.zone.upHttp = upHttp
            return self
        }
        public func upBackupHttp(_ upBackupHttp: String) -> Builder {
            self.zone.upBackupHttp = upBackupHttp
            return self
        }
        public func upHttps(_ upHttps: String) -> Builder {
            self.zone.upHttps = upHttps
            return self
        }
        public func upBackupHttps(_ upBackupHttps: String) -> Builder {
            self.zone.upBackupHttps = upBackupHttps
            return self
        }
        public func upIpHttp(_ upIpHttp: String) -> Builder {
            self.zone.upIpHttp = upIpHttp
            return self
        }
        public func upIpHttps(_ upIpHttps: String) -> Builder {
            self.zone.upIpHttps = upIpHttps
            return self
        }
        public func iovipHttp(_ iovipHttp: String) -> Builder {
            self.zone.iovipHttp = iovipHttp
            return self
        }
        public func iovipHttps(_ iovipHttps: String) -> Builder {
            self.zone.iovipHttps = iovipHttps
            return self
        }
        public func rsHttp(_ rsHttp: String) -> Builder {
            self.zone.rsHttp = rsHttp
            return self
        }
        public func rsHttps(_ rsHttps: String) -> Builder {
            self.zone.rsHttps = rsHttps
            return self
        }
        public func rsfHttp(_ rsfHttp: String) -> Builder {
            self.zone.rsfHttp = rsfHttp
            return self
        }
        public func rsfHttps(_ rsfHttps: String) -> Builder {
            self.zone.rsfHttps = rsfHttps
            return self
        }
        
        public func apiHttp(_ apiHttp: String) -> Builder {
            self.zone.apiHttp = apiHttp
            return self
        }
        
        public func apiHttps(_ apiHttps: String) -> Builder {
            self.zone.apiHttps = apiHttps
            return self
        }
        
        public func build() -> Zone {
            return zone;
        }
    }
}

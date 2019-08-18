//
//  ServiceProvider.swift
//  QiNiuSDK
//
//  Created by 荆学涛 on 2019/8/18.
//

enum ServiceProvider {
    case buckets
}

extension ServiceProvider: TargetType {
    var baseURL: URL {
        return URL(string: "https://rs.qbox.me/")!
    }
    
    var path: String {
        return "buckets"
    }
    
    var method: HTTPMethod {
        return .POST
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return [:]
    }
}

func test() {
    let provider = Provider<ServiceProvider>()
    provider.request(.buckets) { (result) in
        
    }
}

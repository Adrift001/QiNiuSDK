//
//  EventLoopFuture+Extension.swift
//  QiNiuSDK
//
//  Created by 荆学涛 on 2019/8/18.
//

import NIO

public extension EventLoopFuture where Value == Response {
    func mapArray<T: Codable>(_ type: T.Type) -> EventLoopFuture<[Codable]> {
        return self.map { (response) -> ([Codable]) in
            if var body = response.body, let data = (body.readString(length: body.readableBytes) ?? "").data(using: .utf8) {
                QiNiuSDKLogger.default.info("\(response.headers.description)")
                QiNiuSDKLogger.default.info("\(String(data: data, encoding: .utf8) ?? "")")
                let decoder = JSONDecoder()
                do {
                    let array = try decoder.decode([T].self, from: data)
                    return array
                } catch {
                    return []
                }
            } else {
                return []
            }
        }
    }
    
    func mapObject<T: Codable>(_ type: T.Type) -> EventLoopFuture<Codable> {
        return self.map { (response) -> (Codable) in
            if var body = response.body, let data = (body.readString(length: body.readableBytes) ?? "").data(using: .utf8) {
                QiNiuSDKLogger.default.info("\(response.headers.description)")
                QiNiuSDKLogger.default.info("\(String(data: data, encoding: .utf8) ?? "")")
                let decoder = JSONDecoder()
                do {
                    let object = try decoder.decode(T.self, from: data)
                    return object
                } catch {
                    
                }
            } else {
                
            }
            fatalError("")
        }
    }
}

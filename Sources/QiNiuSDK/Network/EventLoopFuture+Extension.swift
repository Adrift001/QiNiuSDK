//
//  EventLoopFuture+Extension.swift
//  QiNiuSDK
//
//  Created by 荆学涛 on 2019/8/18.
//

import NIO

public extension EventLoopFuture where Value == Response {
    
    @discardableResult
    func mapCodable<T: Codable>(_ type: T.Type) -> EventLoopFuture<T> {
        return self.flatMapResult { (response) -> Result<T, QiNiuError> in

            let decoder = JSONDecoder()
            if response.status == .ok {
                if var body = response.body, let data = (body.readString(length: body.readableBytes) ?? "").data(using: .utf8) {
                    do {
                        let object = try decoder.decode(T.self, from: data)
                        return .success(object)
                    } catch {
                        return .failure(QiNiuError.decodeFailed)
                    }
                } else {
                    do {
                        let object = try decoder.decode(T.self, from: "{}".data(using: .utf8)!)
                        return .success(object)
                    } catch {
                        return .failure(QiNiuError.decodeFailed)
                    }
                }
            } else {
                if var body = response.body, let data = (body.readString(length: body.readableBytes) ?? "").data(using: .utf8) {
                    do {
                        let error = try decoder.decode(ErrorModel.self, from: data)
                        return .failure(.message(error.error))
                    } catch {
                        return .failure(QiNiuError.decodeFailed)
                    }
                } else {
                    return .failure(QiNiuError.bodyEmpty)
                }
            }
        }
    }
    
    func `do`(handler: (_ eventLoop: EventLoopFuture) -> ()) -> Self {
        handler(self)
        return self
    }
}

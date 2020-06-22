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
            if var body = response.body, let data = (body.readString(length: body.readableBytes) ?? "").data(using: .utf8) {
                let decoder = JSONDecoder()
                do {
                    
                    guard response.status == .ok else {
                        let error = try decoder.decode(ErrorModel.self, from: data)
                        return .failure(.message(error.error))
                    }
                    
                    let array = try decoder.decode(T.self, from: data)
                    return .success(array)
                } catch {
                    print(error)
                    return .failure(QiNiuError.decodeFailed)
                }
            } else {
                return .failure(QiNiuError.bodyEmpty)
            }
        }
    }
    
    func `do`(handler: (_ eventLoop: EventLoopFuture) -> ()) -> Self {
        handler(self)
        return self
    }
}

//
//  EventLoopFuture+Extension.swift
//  QiNiuSDK
//
//  Created by 荆学涛 on 2019/8/18.
//

import NIO

public extension EventLoopFuture where Value == Response {
    func mapCodable<T: Codable>(_ type: T.Type) -> EventLoopFuture<T> {
        return self.flatMapResult { (response) -> Result<T, QiNiuError> in
            if var body = response.body, let data = (body.readString(length: body.readableBytes) ?? "").data(using: .utf8) {
                let string = String(data: data, encoding: .utf8)
                print(string)
                let decoder = JSONDecoder()
                do {
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
}

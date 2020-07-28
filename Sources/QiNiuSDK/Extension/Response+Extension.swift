//
//  File.swift
//  
//
//  Created by swifter on 2020/7/27.
//

import Foundation
import AsyncHTTPClient

extension EventLoopFuture where Value == Result<Response, Error> {
 
//    func handle<T: Codable>() -> T {
//        whenSuccess { (result) in
//            switch result {
//            case .success(let res):
//                let decoder = JSONDecoder()
//                do {
//                    let object = try decoder.decode(T, from: Data())
//                    return object
//                } catch {
//                    return
//                }
//            case .failure(let error):
//                break
//            }
//        }
//    }
    
}

extension Response {
    func toObject<T: Codable>(_ type: T.Type) throws -> T {
        let decoder = JSONDecoder()
        if var body = self.body, let data = body.readData(length: body.readableBytes) {
            let object = try decoder.decode(T.self, from: data)
            print("=============body==============")
            let string = String(data: data, encoding: .utf8)
            print("=============body==============")
            print(string ?? "")
            return object
        }
        throw QiNiuError.bodyEmpty
    }
}

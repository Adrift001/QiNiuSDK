//
//  NetworkError.swift
//  QiNiuSDK
//
//  Created by 荆学涛 on 2019/11/15.
//

public enum QiNiuError: Error {
    case decodeFailed
    case bodyEmpty
    case requestMapping(String)
    case parameterEncoding(Swift.Error)
    case missingURL
    case jsonEncodingFailed(error: Error)
    case underlying(Swift.Error, Response?)
    case encodableMapping(Swift.Error)
    case httpClientError(Error)
    case message(String)
}

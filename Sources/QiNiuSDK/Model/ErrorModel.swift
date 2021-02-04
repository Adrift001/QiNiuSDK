//
//  File.swift
//  
//
//  Created by swifter on 2020/6/22.
//

import Foundation

public class ErrorModel: Codable {
    var error: String
    var errorCode: String?
    init(error: String, errorCode: String?) {
        self.error = error
        self.errorCode = errorCode
    }
    
    enum CodingKeys: String, CodingKey {
        case error
        case errorCode = "error_code"
    }
    
}

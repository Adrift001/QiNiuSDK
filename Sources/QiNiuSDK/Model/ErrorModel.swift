//
//  File.swift
//  
//
//  Created by swifter on 2020/6/22.
//

import Foundation

public struct ErrorModel: Codable {
    var error = ""
    init(error: String) {
        self.error = error
    }
}

//
//  Errors.swift
//  Cocktails
//
//  Created by Andrew on 03.05.2022.
//

import Foundation

enum Errors {
    case incorrectURL
    case noInitCoder
    
    var description: String {
        switch self {
        case .incorrectURL:
            return "Incorrect baseURL"
        case .noInitCoder:
            return "init(coder:) has not been implemented"
        }
    }
}

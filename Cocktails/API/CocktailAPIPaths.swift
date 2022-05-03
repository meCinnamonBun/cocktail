//
//  CocktailAPIPaths.swift
//  Cocktails
//
//  Created by Andrew on 03.05.2022.
//

import Moya

enum CocktailAPIPaths {
    case getCategories
    case getCocktails(category: String)
}

extension CocktailAPIPaths: TargetType {
    var baseURL: URL {
        let mainURL = CocktailAPI.mainURL
        let apiKey = CocktailAPI.APIKey
        
        let strURL = "\(mainURL)/\(apiKey)"
        
        guard let baseURL = URL(string: strURL) else {
            fatalError(Errors.incorrectURL.description)
        }
        return baseURL
    }
    
    var path: String {
        switch self {
        case .getCategories:
            return "/list.php"
        case .getCocktails:
            return "/filter.php"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        var parameters: [String: Any] = [:]
        
        switch self {
        case .getCategories:
            parameters["c"] = "list"
        case .getCocktails(category: let category):
            parameters["c"] = category
        }
        
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        return nil
    }
}

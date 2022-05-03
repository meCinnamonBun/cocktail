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
        let mainUrl = CocktailAPI.mainUrl
        let apiKey = CocktailAPI.APIKey
        
        let strUrl = "\(mainUrl)/\(apiKey)"
        
        guard let baseURL = URL(string: strUrl) else {
            fatalError(Errors.incorrectUrl.description)
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

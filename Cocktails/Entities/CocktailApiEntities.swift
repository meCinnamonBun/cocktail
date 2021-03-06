//
//  CocktailAPIEntities.swift
//  Cocktails
//
//  Created by Andrew on 03.05.2022.
//

import Foundation

struct CocktailApiCategory: Codable {
    var categoryName: String
    
    enum CodingKeys: String, CodingKey {
        case categoryName = "strCategory"
    }
}

struct CocktailApiDrinkShortInfo: Codable {
    var drinkName: String
    var imageUrl: String
    var idDrink: String
    
    enum CodingKeys: String, CodingKey {
        case drinkName = "strDrink"
        case imageUrl = "strDrinkThumb"
        case idDrink
    }
}

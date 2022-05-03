//
//  CocktailAPIEntities.swift
//  Cocktails
//
//  Created by Andrew on 03.05.2022.
//

import Foundation

struct CocktailAPICategory: Codable {
    var strCategory: String
}

struct CocktailAPIDrinkShortInfo: Codable {
    var strDrink: String
    var strDrinkThumb: String
    var idDrink: String
}

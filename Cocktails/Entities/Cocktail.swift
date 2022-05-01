//
//  Cocktail.swift
//  Cocktails
//
//  Created by Andrew on 30.04.2022.
//

import Foundation

struct CocktailsGroup {
    var categoryName: String
    var cocktails: [Cocktail]
}

struct Cocktail {
    var name: String
    var imageUrl: URL
}

struct CocktailCategory: Equatable {
    var displayingName: String
    var APIName: String
    
    static func == (lhs: CocktailCategory, rhs: CocktailCategory) -> Bool {
        lhs.APIName == rhs.APIName
    }
}

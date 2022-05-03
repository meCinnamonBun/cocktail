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
    var imageUrl: URL?
}

struct CocktailCategory: Equatable {
    var name: String
    
    static func == (lhs: CocktailCategory, rhs: CocktailCategory) -> Bool {
        lhs.name == rhs.name
    }
}

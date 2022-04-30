//
//  Cocktail.swift
//  Cocktails
//
//  Created by Andrew on 30.04.2022.
//

import Foundation

struct CocktailCategory {
    var name: String
    var cocktails: [Cocktail]
}

struct Cocktail {
    var name: String
    var imageUrl: URL
}

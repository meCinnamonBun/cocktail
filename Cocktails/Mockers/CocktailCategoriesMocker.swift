//
//  CocktailCategoriesMocker.swift
//  Cocktails
//
//  Created by Andrew on 01.05.2022.
//

import RxSwift

class CocktailCategoriesMocker {
    class func loadCategoriesFromNetwork() -> Single<[String]> {
        .just([
            "Ordinary Drink",
            "Cocktail",
            "Cocoa",
            "4",
            "5",
            "6",
            "7",
            "8",
            "9"
        ])
    }
    
    class func loadCocktailsFromNetwork() -> Observable<[String]> {
        .just([
            "3-Mile Long Island Iced Tea",
            "410 Gone",
            "50/50"
        ])
        .delay(.seconds(2), scheduler: MainScheduler.instance)
    }
}

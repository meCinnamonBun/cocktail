//
//  CocktailsListInteractor.swift
//  Cocktails
//
//  Created by Andrew on 28.04.2022.
//

import Foundation
import RxSwift

protocol CocktailsListInteractorProtocol: AnyObject {
    func loadCategories() -> Observable<[CocktailCategory]>
    func loadCocktails(for category: CocktailCategory) -> Observable<CocktailsGroup>
}

class CocktailsListInteractor: CocktailsListInteractorProtocol {
    private let api: CocktailAPI = .init()
    
    func loadCategories() -> Observable<[CocktailCategory]> {
        api.getCategories()
            .map { categories -> [CocktailCategory] in
                categories.map { category -> CocktailCategory in
                    .init(displayingName: category.strCategory, APIName: category.strCategory)
                }
            }
    }
    
    func loadCocktails(for category: CocktailCategory) -> Observable<CocktailsGroup> {
        api.getCocktails(for: category.APIName)
            .map { cocktails -> CocktailsGroup in
                let ct = cocktails.map { cocktail -> Cocktail in
                    return .init(name: cocktail.strDrink, imageUrl: URL(string: cocktail.strDrinkThumb))
                }
                
                return .init(categoryName: category.displayingName, cocktails: ct)
            }
    }
}

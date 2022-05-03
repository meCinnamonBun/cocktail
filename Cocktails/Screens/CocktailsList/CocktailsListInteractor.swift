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
    
    // MARK: - CocktailsListInteractorProtocol Methods
    
    func loadCategories() -> Observable<[CocktailCategory]> {
        api.getCategories()
            .map { categories -> [CocktailCategory] in
                categories.map { category -> CocktailCategory in
                    .init(name: category.categoryName)
                }
            }
    }
    
    func loadCocktails(for category: CocktailCategory) -> Observable<CocktailsGroup> {
        api.getCocktails(for: category.name)
            .map { cocktails -> CocktailsGroup in
                let ct = cocktails.map { cocktail -> Cocktail in
                    return .init(name: cocktail.drinkName, imageUrl: URL(string: cocktail.imageUrl))
                }
                
                return .init(categoryName: category.name, cocktails: ct)
            }
    }
}

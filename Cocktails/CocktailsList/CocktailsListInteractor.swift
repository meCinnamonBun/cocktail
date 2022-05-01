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
    func loadCategories() -> Observable<[CocktailCategory]> {
        CocktailCategoriesMocker.loadCategoriesFromNetwork()
            .map { stringCategories -> [CocktailCategory] in
                stringCategories.map { stringCategory -> CocktailCategory in
                    .init(displayingName: stringCategory, APIName: stringCategory)
                }
            }
            .asObservable()
    }
    
    func loadCocktails(for category: CocktailCategory) -> Observable<CocktailsGroup> {
        CocktailCategoriesMocker.loadCocktailsFromNetwork()
            .map { stringCocktails -> CocktailsGroup in
                CocktailsGroupMocker.generateEmptyNameCategory(for: stringCocktails, and: category.displayingName)
            }
    }
}

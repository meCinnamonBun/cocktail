//
//  CocktailsListPresenter.swift
//  Cocktails
//
//  Created by Andrew on 27.04.2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol CocktailsListPresenterProtocol: AnyObject {
    var router: CocktailsListRouterProtocol { set get }
    var interactor: CocktailsListInteractorProtocol { set get }
    
    // Inputs
    
    // Outputs
    
    var cocktailsCategories: Driver<[CocktailCategory]> { get }
}

class CocktailsListPresenter: CocktailsListPresenterProtocol {
    var interactor: CocktailsListInteractorProtocol
    var router: CocktailsListRouterProtocol
    
    var cocktailsCategories: Driver<[CocktailCategory]> {
        cocktailsCategoriesRelay.asDriver(onErrorJustReturn: [])
    }
    
    private let cocktailsCategoriesRelay: BehaviorRelay<[CocktailCategory]> = .init(value: CocktailCategoryMocker.generateCategories()) // !!!
    
    init(router: CocktailsListRouterProtocol,
         interactor: CocktailsListInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
}

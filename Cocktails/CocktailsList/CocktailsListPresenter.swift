//
//  CocktailsListPresenter.swift
//  Cocktails
//
//  Created by Andrew on 27.04.2022.
//

import Foundation

protocol CocktailsListPresenterProtocol: AnyObject {
    var router: CocktailsListRouterProtocol { set get }
    var interactor: CocktailsListInteractorProtocol { set get }
}

class CocktailsListPresenter: CocktailsListPresenterProtocol {
    var interactor: CocktailsListInteractorProtocol
    var router: CocktailsListRouterProtocol
    
    init(router: CocktailsListRouterProtocol,
         interactor: CocktailsListInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
}

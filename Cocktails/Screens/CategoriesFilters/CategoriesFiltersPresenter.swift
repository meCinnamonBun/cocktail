//
//  CategoriesFiltersPresenter.swift
//  Cocktails
//
//  Created by Andrew on 02.05.2022.
//

import RxSwift
import RxCocoa

protocol CategoriesFiltersPresenterProtocol: AnyObject {
    var interactor: CategoriesFiltersInteractor { set get }
    var router: CategoriesFiltersRouter { set get }
}

class CategoriesFiltersPresenter: CategoriesFiltersPresenterProtocol {
    var interactor: CategoriesFiltersInteractor
    var router: CategoriesFiltersRouter
    
    init(interactor: CategoriesFiltersInteractor,
         router: CategoriesFiltersRouter) {
        self.interactor = interactor
        self.router = router
    }
}

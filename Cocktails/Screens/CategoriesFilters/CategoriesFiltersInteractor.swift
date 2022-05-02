//
//  CategoriesFiltersInteractor.swift
//  Cocktails
//
//  Created by Andrew on 02.05.2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol CategoriesFiltersInteractorProtocol: AnyObject {
    var allCategories: Observable<[CocktailCategory]> { get }
    var selectedCategories: Observable<[CocktailCategory]> { get }
    
    var categoriesToSelect: AnyObserver<[CocktailCategory]> { get }
}

class CategoriesFiltersInteractor: CategoriesFiltersInteractorProtocol {
    var allCategories: Observable<[CocktailCategory]> {
        allCategoriesRelay.asObservable()
    }
    var selectedCategories: Observable<[CocktailCategory]>
    
    var categoriesToSelect: AnyObserver<[CocktailCategory]>
    
    private let allCategoriesRelay: BehaviorRelay<[CocktailCategory]>
    
    init(with categories: [CocktailCategory],
         selectedCategories: Observable<[CocktailCategory]>,
         categoriesToSelect: AnyObserver<[CocktailCategory]>) {
        self.allCategoriesRelay = .init(value: categories)
        self.selectedCategories = selectedCategories
        self.categoriesToSelect = categoriesToSelect
    }
}

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
    // MARK: - CategoriesFiltersInteractorProtocol
    
    var allCategories: Observable<[CocktailCategory]> {
        allCategoriesRelay.asObservable()
    }
    var selectedCategories: Observable<[CocktailCategory]> {
        selectedCategoriesRelay.asObservable()
    }
    
    var categoriesToSelect: AnyObserver<[CocktailCategory]>
    
    // MARK: - Private Properties
    
    private let allCategoriesRelay: BehaviorRelay<[CocktailCategory]>
    private let selectedCategoriesRelay: BehaviorRelay<[CocktailCategory]>
    
    // MARK: - LifeCycle
    
    init(with categories: [CocktailCategory],
         selectedCategories: [CocktailCategory],
         categoriesToSelect: AnyObserver<[CocktailCategory]>) {
        self.allCategoriesRelay = .init(value: categories)
        self.selectedCategoriesRelay = .init(value: selectedCategories)
        self.categoriesToSelect = categoriesToSelect
    }
}

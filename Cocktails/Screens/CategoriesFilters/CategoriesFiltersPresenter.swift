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
    
    // Output
    var allCategories: Driver<[CocktailCategory]> { get }
    var selectedCategories: Driver<[CocktailCategory]> { get }
}

class CategoriesFiltersPresenter: CategoriesFiltersPresenterProtocol {
    var interactor: CategoriesFiltersInteractor
    var router: CategoriesFiltersRouter
    
    // Outputs
    var allCategories: Driver<[CocktailCategory]>{
        allCategoriesRelay.asDriver(onErrorDriveWith: .empty())
    }
    var selectedCategories: Driver<[CocktailCategory]> {
        selectedCategoriesRelay.asDriver(onErrorDriveWith: .empty())
    }
    
    // Output Relays
    
    private let allCategoriesRelay: BehaviorRelay<[CocktailCategory]> = .init(value: [])
    private let selectedCategoriesRelay: BehaviorRelay<[CocktailCategory]> = .init(value: [])
    
    private let disposeBag: DisposeBag = .init()
    
    init(interactor: CategoriesFiltersInteractor,
         router: CategoriesFiltersRouter) {
        self.interactor = interactor
        self.router = router
        
        setupBindings()
    }
    
    private func setupBindings() {
        interactor.allCategories
            .bind(to: allCategoriesRelay)
            .disposed(by: disposeBag)
        
        interactor.selectedCategories
            .bind(to: selectedCategoriesRelay)
            .disposed(by: disposeBag)
    }
}

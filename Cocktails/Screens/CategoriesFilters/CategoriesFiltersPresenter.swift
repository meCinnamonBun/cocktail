//
//  CategoriesFiltersPresenter.swift
//  Cocktails
//
//  Created by Andrew on 02.05.2022.
//

import RxSwift
import RxCocoa

protocol CategoriesFiltersPresenterProtocol: AnyObject {
    var interactor: CategoriesFiltersInteractorProtocol { set get }
    var router: CategoriesFiltersRouterProtocol { set get }
    
    // MARK: - Output
    
    var allCategories: Driver<[CocktailCategory]> { get }
    var selectedStartCategories: Driver<[CocktailCategory]> { get }
    
    // MARK: - Input
    
    var applyFilters: AnyObserver<Void> { get }
    
    var addCategoryToSelected: AnyObserver<CocktailCategory> { get }
    var removeCategoryFromSelected: AnyObserver<CocktailCategory> { get }
}

class CategoriesFiltersPresenter: CategoriesFiltersPresenterProtocol {
    // MARK: - CategoriesFiltersPresenterProtocol
    
    var interactor: CategoriesFiltersInteractorProtocol
    var router: CategoriesFiltersRouterProtocol
    
    // MARK: - CategoriesFiltersPresenterProtocol Inputs
    
    var applyFilters: AnyObserver<Void> {
        applyFiltersSubject.asObserver()
    }
    
    var addCategoryToSelected: AnyObserver<CocktailCategory> {
        addCategoryToSelectedSubject.asObserver()
    }
    var removeCategoryFromSelected: AnyObserver<CocktailCategory> {
        removeCategoryFromSelectedSubject.asObserver()
    }
    
    // MARK: - CategoriesFiltersPresenterProtocol Outputs
    
    var allCategories: Driver<[CocktailCategory]>{
        allCategoriesRelay.asDriver(onErrorDriveWith: .empty())
    }
    var selectedStartCategories: Driver<[CocktailCategory]> {
        selectedStartCategoriesRelay.asDriver(onErrorDriveWith: .empty())
    }
    
    // MARK: - Input Subjects
    
    var applyFiltersSubject: PublishSubject<Void> = .init()
    
    var addCategoryToSelectedSubject: PublishSubject<CocktailCategory> = .init()
    var removeCategoryFromSelectedSubject: PublishSubject<CocktailCategory> = .init()
    
    // MARK: - Output Relays
    
    private let allCategoriesRelay: BehaviorRelay<[CocktailCategory]> = .init(value: [])
    private let selectedStartCategoriesRelay: BehaviorRelay<[CocktailCategory]> = .init(value: [])
    
    private let selectedCategoriesRelay: BehaviorRelay<[CocktailCategory]> = .init(value: [])
    
    private let disposeBag: DisposeBag = .init()
    
    // MARK: - LifeCycle
    
    init(interactor: CategoriesFiltersInteractor,
         router: CategoriesFiltersRouter) {
        self.interactor = interactor
        self.router = router
        
        setupBindings()
    }
    
    // MARK: - Private Methods
    
    private func setupBindings() {
        interactor.allCategories
            .bind(to: allCategoriesRelay)
            .disposed(by: disposeBag)
        
        interactor.selectedCategories
            .bind(to: selectedStartCategoriesRelay)
            .disposed(by: disposeBag)
        
        selectedStartCategoriesRelay
            .bind(to: selectedCategoriesRelay)
            .disposed(by: disposeBag)
        
        addCategoryToSelectedSubject
            .withLatestFrom(selectedCategoriesRelay) { ($0, $1) }
            .map { newCategory, selected -> [CocktailCategory] in
                var newSelected = selected
                newSelected.append(newCategory)
                return newSelected
            }
            .bind(to: selectedCategoriesRelay)
            .disposed(by: disposeBag)
        
        removeCategoryFromSelectedSubject
            .withLatestFrom(selectedCategoriesRelay) { ($0, $1) }
            .map { removeCategory, selected -> [CocktailCategory] in
                var newSelected = selected
                newSelected.removeAll(where: { $0 == removeCategory })
                return newSelected
            }
            .bind(to: selectedCategoriesRelay)
            .disposed(by: disposeBag)
        
        applyFiltersSubject
            .withLatestFrom(selectedCategoriesRelay)
            .withLatestFrom(allCategoriesRelay) { ($0, $1) }
            .map { selected, all in
                all.filter({ selected.contains($0) })
            }
            .bind(to: interactor.categoriesToSelect)
            .disposed(by: disposeBag)
        
        applyFiltersSubject
            .bind { [unowned self] _ in
                router.close()
            }
            .disposed(by: disposeBag)
    }
}

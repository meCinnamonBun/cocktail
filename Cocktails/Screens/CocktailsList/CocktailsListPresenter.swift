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
    var interactor: CocktailsListInteractorProtocol { set get }
    var router: CocktailsListRouterProtocol { set get }
    
    // Inputs
    
    var showFilters: AnyObserver<Void> { get }
    var loadNextCategory: AnyObserver<Void> { get }
    
    // Outputs
    
    var cocktailsCategories: Driver<[CocktailsGroup]> { get }
    var isLoading: Driver<Bool> { get }
}

class CocktailsListPresenter: CocktailsListPresenterProtocol {
    var interactor: CocktailsListInteractorProtocol
    var router: CocktailsListRouterProtocol
    
    // Inputs
    
    var showFilters: AnyObserver<Void> {
        showFiltersSubject.asObserver()
    }
    
    var loadNextCategory: AnyObserver<Void> {
        loadNextCategorySubject.asObserver()
    }
    
    // Outputs
    
    var cocktailsCategories: Driver<[CocktailsGroup]> {
        cocktailsCategoriesRelay.asDriver(onErrorJustReturn: [])
    }
    
    var isLoading: Driver<Bool> {
        isLoadingRelay.asDriver(onErrorDriveWith: .never())
    }
    
    // Input Subjects
    
    private let showFiltersSubject: PublishSubject<Void> = .init()
    private let loadNextCategorySubject: PublishSubject<Void> = .init()
    
    // Output Relays
    
    private let cocktailsCategoriesRelay: BehaviorRelay<[CocktailsGroup]> = .init(value: [])
    private let isLoadingRelay: PublishRelay<Bool> = .init()
    
    // Private properties
    
    private let allCategories: BehaviorRelay<[CocktailCategory]> = .init(value: [])
    private let filtredCategories: BehaviorRelay<[CocktailCategory]> = .init(value: [])
    private var nextIndex: BehaviorRelay<Int> = .init(value: 0)
    
    private let categoriesToFilter: BehaviorSubject<[CocktailCategory]> = .init(value: [])
    
    private let disposeBag: DisposeBag = .init()
    
    init(router: CocktailsListRouterProtocol,
         interactor: CocktailsListInteractorProtocol) {
        self.router = router
        self.interactor = interactor
        
        setupBindings()
    }
    
    private func setupBindings() {
        setupCategoriesBindings()
        setupCocktailsBindings()
        
        showFiltersSubject
            .withLatestFrom(allCategories)
            .withLatestFrom(categoriesToFilter) { ($0, $1) }
            .bind { [unowned self] all, filtred in
                router.openFiltersViewController(with: all,
                                                 selectedCategories: filtred,
                                                 categoriesToSelect: categoriesToFilter.asObserver())
            }
            .disposed(by: disposeBag)
    }
    
    private let categoryToLoad: BehaviorRelay<CocktailCategory?> = .init(value: nil)
    
    private func setupCategoriesBindings() {
        interactor
           .loadCategories()
           .bind(to: allCategories)
           .disposed(by: disposeBag)
       
       let changedCategories = Observable.combineLatest(allCategories, categoriesToFilter)
           .map { all, filter in
               filter.isEmpty ? all : filter
           }
           .distinctUntilChanged()
       
       changedCategories
           .bind(to: filtredCategories)
           .disposed(by: disposeBag)
       
       filtredCategories
           .map { _ in 0 }
           .bind(to: nextIndex)
           .disposed(by: disposeBag)
        
        filtredCategories
            .compactMap { $0.first }
            .bind(to: categoryToLoad)
            .disposed(by: disposeBag)
       
       filtredCategories
           .map { _ -> [CocktailsGroup] in [] }
           .bind(to: cocktailsCategoriesRelay)
           .disposed(by: disposeBag)
       
       loadNextCategorySubject
           .withLatestFrom(nextIndex)
           .map { $0 + 1 }
           .bind(to: nextIndex)
           .disposed(by: disposeBag)
    }
    
    private func setupCocktailsBindings() {
        nextIndex
            .filter { $0 != 0 }
            .withLatestFrom(filtredCategories) { ($0, $1) }
            .compactMap { nextIndex, categories -> CocktailCategory? in
                if nextIndex < categories.count {
                    return categories[nextIndex]
                }

                return nil
            }
            .bind(to: categoryToLoad)
            .disposed(by: disposeBag)
        
        categoryToLoad
            .map { _ in return true }
            .bind(to: isLoadingRelay)
            .disposed(by: disposeBag)
        
        let loadedCategory = categoryToLoad
            .compactMap { $0 }
            .flatMap { [unowned self] category -> Observable<CocktailsGroup> in
                interactor.loadCocktails(for: category)
            }
            .withLatestFrom(cocktailsCategoriesRelay) { ($0, $1) }
            .map { newGroup, groups -> [CocktailsGroup] in
                var newGroups = groups
                newGroups.append(newGroup)
                return newGroups
            }
        
        loadedCategory
            .map { _ in return false }
            .bind(to: isLoadingRelay)
            .disposed(by: disposeBag)
        
        loadedCategory
            .bind(to: cocktailsCategoriesRelay)
            .disposed(by: disposeBag)
    }
}

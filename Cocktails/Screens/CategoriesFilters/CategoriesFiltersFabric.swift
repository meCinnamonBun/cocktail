//
//  CategoriesFiltersFabric.swift
//  Cocktails
//
//  Created by Andrew on 02.05.2022.
//

import UIKit
import RxSwift

protocol CategoriesFiltersFabricProtocol: AnyObject {
    static func createViewController(with categories: [CocktailCategory],
                                     selectedCategories: [CocktailCategory],
                                     categoriesToSelect: AnyObserver<[CocktailCategory]>) -> UIViewController
}

class CategoriesFiltersFabric: CategoriesFiltersFabricProtocol {
    static func createViewController(with categories: [CocktailCategory],
                                     selectedCategories: [CocktailCategory],
                                     categoriesToSelect: AnyObserver<[CocktailCategory]>) -> UIViewController {
        let router: CategoriesFiltersRouter = .init()
        let interactor: CategoriesFiltersInteractor = .init(with: categories,
                                                            selectedCategories: selectedCategories,
                                                            categoriesToSelect: categoriesToSelect)
        let presenter: CategoriesFiltersPresenter = .init(interactor: interactor, router: router)
        let viewController: CategoriesFiltersViewController = .init(presenter: presenter)
        
        router.viewController = viewController
        
        return viewController
    }
}

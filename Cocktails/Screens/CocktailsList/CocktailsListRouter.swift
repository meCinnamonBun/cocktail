//
//  CocktailsListRouter.swift
//  Cocktails
//
//  Created by Andrew on 27.04.2022.
//

import UIKit
import RxSwift

protocol CocktailsListRouterProtocol: AnyObject {
    func openFiltersViewController(with categories: [CocktailCategory],
                                   selectedCategories: [CocktailCategory],
                                   categoriesToSelect: AnyObserver<[CocktailCategory]>)
}

class CocktailsListRouter: CocktailsListRouterProtocol {
    
    weak var viewController: CocktailsListViewController?
    
    // MARK: - CocktailsListRouterProtocol Methods
    
    func openFiltersViewController(with categories: [CocktailCategory],
                                   selectedCategories: [CocktailCategory],
                                   categoriesToSelect: AnyObserver<[CocktailCategory]>) {
        let filtersViewController = CategoriesFiltersFabric.createViewController(with: categories,
                                                                                 selectedCategories: selectedCategories,
                                                                                 categoriesToSelect: categoriesToSelect)
        viewController?.navigationController?.pushViewController(filtersViewController, animated: true)
    }
}

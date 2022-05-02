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
                                   selectedCategories: Observable<[CocktailCategory]>,
                                   categoriesToSelect: AnyObserver<[CocktailCategory]>)
}

class CocktailsListRouter: CocktailsListRouterProtocol {
    
    weak var viewController: CocktailsListViewController?
    
    func openFiltersViewController(with categories: [CocktailCategory],
                                   selectedCategories: Observable<[CocktailCategory]>,
                                   categoriesToSelect: AnyObserver<[CocktailCategory]>) {
        let filtersViewController = UIViewController() // !!!
        viewController?.navigationController?.pushViewController(filtersViewController, animated: true)
    }
}

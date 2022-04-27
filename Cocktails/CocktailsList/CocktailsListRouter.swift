//
//  CocktailsListRouter.swift
//  Cocktails
//
//  Created by Andrew on 27.04.2022.
//

import UIKit

protocol CocktailsListRouterProtocol: AnyObject {
    func openFiltersViewController()
}

class CocktailsListRouter: CocktailsListRouterProtocol {
    
    weak var viewController: CocktailsListViewController?
    
    func openFiltersViewController() {
        let filtersViewController = UIViewController() // !!!
        viewController?.navigationController?.pushViewController(filtersViewController, animated: true)
    }
}

//
//  CocktailsListFabric.swift
//  Cocktails
//
//  Created by Andrew on 27.04.2022.
//

import UIKit

protocol CocktailsListFabricProtocol: AnyObject {
    static func createViewController() -> UIViewController
}

class CocktailsListFabric: CocktailsListFabricProtocol {
    static func createViewController() -> UIViewController {
        let router: CocktailsListRouter = .init()
        let interactor: CocktailsListInteractor = .init()
        let presenter: CocktailsListPresenter = .init(router: router, interactor: interactor)
        let viewController: CocktailsListViewController = .init(presenter: presenter)
        
        router.viewController = viewController
        
        return viewController
    }
}

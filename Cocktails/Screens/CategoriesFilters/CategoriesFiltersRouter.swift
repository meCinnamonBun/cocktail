//
//  CategoriesFiltersRouter.swift
//  Cocktails
//
//  Created by Andrew on 02.05.2022.
//

import Foundation

protocol CategoriesFiltersRouterProtocol: AnyObject {
    func close()
}

class CategoriesFiltersRouter: CategoriesFiltersRouterProtocol {
    weak var viewController: CategoriesFiltersViewController?
    
    // MARK: - CategoriesFiltersRouterProtocol
    
    func close() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}

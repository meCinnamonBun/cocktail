//
//  CocktailsListViewController.swift
//  Cocktails
//
//  Created by Andrew on 27.04.2022.
//

import UIKit

protocol CocktailsListViewProtocol: AnyObject {
    
}

class CocktailsListViewController: UIViewController, CocktailsListViewProtocol {
    var presenter: CocktailsListPresenterProtocol
    
    init(presenter: CocktailsListPresenterProtocol) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .red
    }
}

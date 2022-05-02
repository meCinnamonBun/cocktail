//
//  CategoriesFiltersViewController.swift
//  Cocktails
//
//  Created by Andrew on 02.05.2022.
//

import UIKit
import RxSwift
import RxCocoa

class CategoriesFiltersViewController: UIViewController {
    var presenter: CategoriesFiltersPresenterProtocol
    
    private let _view: CategoriesFiltersDisplayingViewProtocol?
    
    init(presenter: CategoriesFiltersPresenterProtocol) {
        self.presenter = presenter
        self._view = CategoriesFiltersView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = _view
    }
    
    override func viewDidLoad() {
        title = "Filters"
    }
}

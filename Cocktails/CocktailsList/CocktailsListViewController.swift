//
//  CocktailsListViewController.swift
//  Cocktails
//
//  Created by Andrew on 27.04.2022.
//

import UIKit
import RxSwift
import RxCocoa

protocol CocktailsListViewProtocol: AnyObject {
    
}

class CocktailsListViewController: UIViewController, CocktailsListViewProtocol {
    private let _view: CocktailsListDisplayingViewProtocol?
    
    var presenter: CocktailsListPresenterProtocol
    
    private let disposeBag: DisposeBag = .init()
    
    init(presenter: CocktailsListPresenterProtocol) {
        self.presenter = presenter
        self._view = CocktailsListView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = _view
    }
    
    override func viewDidLoad() {
        title = "Drinks"
        
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setupBindings() {
        presenter.cocktailsCategories
            .drive(onNext: { [weak self] categories in
                self?._view?.updateView(with: categories)
            })
            .disposed(by: disposeBag)
    }
}

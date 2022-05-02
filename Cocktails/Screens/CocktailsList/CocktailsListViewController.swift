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
    var presenter: CocktailsListPresenterProtocol
    
    private let _view: CocktailsListDisplayingViewProtocol?
    private let disposeBag: DisposeBag = .init()
    
    private lazy var filterButton: UIBarButtonItem = .init(image: R.image.filter(),
                                                           style: .plain,
                                                           target: nil,
                                                           action: nil)
    
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
        
        _view?.didReachBottom = { [weak self] in
            self?.presenter.loadNextCategory.onNext(())
        }
        
        _view?.startLoading()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        setupFilterButton()
    }
    
    private func setupBindings() {
        presenter.cocktailsCategories
            .drive(onNext: { [weak self] categories in
                self?._view?.updateView(with: categories)
            })
            .disposed(by: disposeBag)
        
        presenter.isLoading
            .drive(onNext: { [weak self] loading in
                if loading {
                    self?._view?.startLoading()
                } else {
                    self?._view?.stopLoading()
                }
            })
            .disposed(by: disposeBag)
        
        filterButton.rx.tap
            .bind(to: presenter.showFilters)
            .disposed(by: disposeBag)
    }
    
    private func setupFilterButton() {
        navigationItem.setRightBarButton(filterButton, animated: true)
    }
}

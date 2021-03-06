//
//  CocktailsListViewController.swift
//  Cocktails
//
//  Created by Andrew on 27.04.2022.
//

import UIKit
import RxSwift
import RxCocoa

class CocktailsListViewController: UIViewController {
    var presenter: CocktailsListPresenterProtocol
    
    private let _view: CocktailsListDisplayingViewProtocol?
    private let disposeBag: DisposeBag = .init()
    
    private lazy var filterButton: BadgedBarButtonItem = .init(image: R.image.filter(),
                                                               style: .plain,
                                                               target: nil,
                                                               action: nil)
    
    // MARK: - LifeCycle
    
    init(presenter: CocktailsListPresenterProtocol) {
        self.presenter = presenter
        self._view = CocktailsListView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError(Errors.noInitCoder.description)
    }
    
    override func loadView() {
        self.view = _view
    }
    
    override func viewDidLoad() {
        title = .title
        
        setupBindings()
        setupViewCallbacks()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        setupFilterButton()
    }
    
    // MARK: - Private methods
    
    private func setupViewCallbacks() {
        _view?.didReachBottom = { [weak self] in
            self?.presenter.loadNextCategory.onNext(())
        }
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
        
        presenter.hasFilters
            .drive(onNext: { [weak self] flag in
                if flag {
                    self?.filterButton.addBadge()
                } else {
                    self?.filterButton.removeBadge()
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func setupFilterButton() {
        navigationItem.setRightBarButton(filterButton, animated: true)
    }
}

// MARK: - Constants

private extension String {
    static let title: String = "Drinks"
}

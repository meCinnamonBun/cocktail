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
    
    private let disposeBag: DisposeBag = .init()
    
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
        
        setupViewCallbacks()
        setupBindings()
    }
    
    private func setupViewCallbacks() {
        _view?.applyFilters = { [weak self] in
            self?.presenter.applyFilters.onNext(())
        }
        _view?.didSelectCategory = { [weak self] category in
            self?.presenter.addCategoryToSelected.onNext(category)
        }
        _view?.didDeselectCategory = { [weak self] category in
            self?.presenter.removeCategoryFromSelected.onNext(category)
        }
    }
    
    private func setupBindings() {
        Observable.zip(presenter.allCategories.asObservable(),
                       presenter.selectedStartCategories.asObservable())
            .bind { [weak self] all, selected in
                self?._view?.updateAllCategories(all)
                self?._view?.setSelectedCategories(selected)
            }
            .disposed(by: disposeBag)
    }
}

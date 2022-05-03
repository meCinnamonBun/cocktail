//
//  CategoriesFiltersView.swift
//  Cocktails
//
//  Created by Andrew on 02.05.2022.
//

import UIKit
import SnapKit

protocol CategoriesFiltersDisplayingViewProtocol: UIView {
    func updateAllCategories(_ categories: [CocktailCategory])
    func setSelectedCategories(_ categories: [CocktailCategory])
    
    var applyFilters: (() -> ())? { set get }
    var didSelectCategory: ((CocktailCategory) -> ())? { set get }
    var didDeselectCategory: ((CocktailCategory) -> ())? { set get }
}

final class CategoriesFiltersView: UIView, CategoriesFiltersDisplayingViewProtocol {
    private var categories: [CocktailCategory] = []
    private var selectedStartCategories: [CocktailCategory] = []
    
    private lazy var applyButton: UIButton = {
        let view = UIButton(type: .system)
        
        view.layer.cornerRadius = 12
        view.backgroundColor = .systemBlue
        view.tintColor = .white
        view.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        view.setTitle("Apply Filters", for: .normal)
        view.addTarget(self, action: #selector(didTapApllyButton), for: .touchUpInside)
        
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        
        view.allowsMultipleSelection = true
        
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        addSubviews(tableView, applyButton)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        tableView.snp.makeConstraints { maker in
            maker.left.right.equalToSuperview()
            maker.top.equalToSuperview()
        }
        
        applyButton.snp.makeConstraints { maker in
            maker.left.right.equalToSuperview().inset(16)
            maker.bottom.equalToSuperview().inset(48)
            maker.top.equalTo(tableView.snp.bottom)
            maker.height.equalTo(50)
        }
        
        backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc
    private func didTapApllyButton() {
        applyFilters?()
    }
    
    // MARK: - CategoriesFiltersDisplayingViewProtocol
    
    var applyFilters: (() -> ())?
    var didSelectCategory: ((CocktailCategory) -> ())?
    var didDeselectCategory: ((CocktailCategory) -> ())?
    
    func updateAllCategories(_ categories: [CocktailCategory]) {
        self.categories = categories
        tableView.reloadData()
    }
    
    func setSelectedCategories(_ categories: [CocktailCategory]) {
        selectedStartCategories = categories
        categories.forEach { category in
            guard let index = self.categories.firstIndex(where: { $0 == category }) else {
                return
            }
            
            let indexPath: IndexPath = .init(row: index, section: 0)
            
            let cell = tableView.cellForRow(at: indexPath)
            cell?.accessoryView?.isHidden = false
            
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        }
    }
}

extension CategoriesFiltersView: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let imageView = UIImageView(frame: .init(x: 0, y: 0, width: 15, height: 15))
        imageView.image = R.image.checkMark()
        
        let category = categories[indexPath.row]
        
        cell.selectionStyle = .none
        cell.textLabel?.text = category.displayingName
        cell.accessoryView = imageView
        
        let isSelected = selectedStartCategories.contains(category)
        
        cell.accessoryView?.isHidden = !isSelected
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryView?.isHidden = false
        
        let category = categories[indexPath.row]
        
        didSelectCategory?(category)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryView?.isHidden = true
        
        let category = categories[indexPath.row]
        
        didDeselectCategory?(category)
    }
}

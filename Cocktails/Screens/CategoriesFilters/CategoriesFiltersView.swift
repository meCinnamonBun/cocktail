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
}

final class CategoriesFiltersView: UIView, CategoriesFiltersDisplayingViewProtocol {
    private var categories: [CocktailCategory] = []
    
    private lazy var applyButton: UIButton = {
        let view = UIButton(type: .system)
        
        view.layer.cornerRadius = 12
        view.backgroundColor = .systemBlue
        view.tintColor = .white
        view.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        view.setTitle("Apply Filters", for: .normal)
        
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
    
    // MARK: - CategoriesFiltersDisplayingViewProtocol
    
    func updateAllCategories(_ categories: [CocktailCategory]) {
        self.categories = categories
        tableView.reloadData()
    }
    
    func setSelectedCategories(_ categories: [CocktailCategory]) {
        categories.forEach { category in
            guard let index = self.categories.firstIndex(where: { $0 == category }) else {
                return
            }
            
            tableView.selectRow(at: .init(row: index, section: 0), animated: true, scrollPosition: .none)
        }
    }
}

extension CategoriesFiltersView: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = categories[indexPath.row].displayingName
        
        return cell
    }
    
}

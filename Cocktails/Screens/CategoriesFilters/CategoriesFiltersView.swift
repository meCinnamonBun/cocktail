//
//  CategoriesFiltersView.swift
//  Cocktails
//
//  Created by Andrew on 02.05.2022.
//

import UIKit
import SnapKit

protocol CategoriesFiltersDisplayingViewProtocol: UIView {
    
}

final class CategoriesFiltersView: UIView, CategoriesFiltersDisplayingViewProtocol {
    private lazy var applyButton: UIButton = {
        let view = UIButton(type: .system)
        
        view.setTitle("Apply Filters", for: .normal)
        
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        
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
        
//        tableView.delegate = self
//        tableView.dataSource = self
    }
}

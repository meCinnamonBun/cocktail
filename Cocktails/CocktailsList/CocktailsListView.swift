//
//  CocktailsListView.swift
//  Cocktails
//
//  Created by Andrew on 30.04.2022.
//

import UIKit
import SnapKit
import MBProgressHUD

protocol CocktailsListDisplayingViewProtocol: UIView {
    func updateView(with cocktailCategories: [CocktailCategory])
    func startLoading()
    func stopLoading()
}

final class CocktailsListView: UIView, CocktailsListDisplayingViewProtocol {
    private var cocktailCategories: [CocktailCategory] = []
    
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
        addSubview(tableView)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(CocktailsListViewCell.self, forCellReuseIdentifier: CocktailsListViewCell.reuiseId)
        
        tableView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        
        backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - CocktailsListDisplayingViewProtocol
    
    func updateView(with cocktailCategories: [CocktailCategory]) {
        self.cocktailCategories = cocktailCategories
        tableView.reloadData()
    }
    
    func startLoading() {
        let loadingNotification = MBProgressHUD.showAdded(to: self, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
    }
    
    func stopLoading() {
        MBProgressHUD.hide(for: self, animated: true)
    }
}

extension CocktailsListView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        cocktailCategories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cocktailCategories[section].cocktails.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        cocktailCategories[section].name
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let category = cocktailCategories[indexPath.section]
        let coctail = category.cocktails[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CocktailsListViewCell.reuiseId) as? CocktailsListViewCell else {
            return UITableViewCell()
        }
        
        cell.loadImage(for: coctail.imageUrl)
        cell.title = coctail.name
        
        return cell
    }
}

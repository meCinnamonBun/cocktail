//
//  CocktailsListViewCell.swift
//  Cocktails
//
//  Created by Andrew on 30.04.2022.
//

import UIKit
import Kingfisher

class CocktailsListViewCell: UITableViewCell {
    static let reuiseId: String = "CocktailsListViewCell"
    
    var title: String? {
        get {
            titleLabel.text
        } set {
            titleLabel.text = newValue
        }
    }
    
    private lazy var iconView: UIImageView = {
        let view: UIImageView = .init()
        
        view.backgroundColor = .lightGray
        
        return view
    }()
    
    private lazy var noImageTitleLabel: UILabel = {
        let view: UILabel = .init()
        
        view.font = .systemFont(ofSize: 9, weight: .semibold)
        view.textColor = .darkGray
        view.text = "Cocktails"
        view.textAlignment = .center
        
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view: UILabel = .init()
        
        view.font = .systemFont(ofSize: 17)
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubviews(titleLabel, iconView, noImageTitleLabel)
        
        iconView.snp.makeConstraints { maker in
            maker.left.equalToSuperview().inset(16)
            maker.top.bottom.equalToSuperview().inset(10)
            maker.height.width.equalTo(52)
        }
        
        titleLabel.snp.makeConstraints { maker in
            maker.left.equalTo(iconView.snp.right).offset(10)
            maker.right.equalToSuperview().inset(16)
            maker.centerY.equalToSuperview()
        }
        
        noImageTitleLabel.snp.makeConstraints { maker in
            maker.centerY.equalTo(iconView)
            maker.left.equalTo(iconView).offset(4)
            maker.right.equalTo(iconView).inset(4)
        }
    }
    
    func loadImage(for url: URL) {
        iconView.image = nil
        iconView.backgroundColor = .systemGray5
        noImageTitleLabel.isHidden = false
        iconView.kf.setImage(with: url, completionHandler: { [weak self] _ in
            self?.iconView.backgroundColor = nil
            self?.noImageTitleLabel.isHidden = true
        })
    }
}

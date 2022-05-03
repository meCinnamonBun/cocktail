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
    
    // MARK: - Computed Properties
    
    var title: String? {
        get {
            titleLabel.text
        } set {
            titleLabel.text = newValue
        }
    }
    
    // MARK: - UI
    
    private lazy var iconView: UIImageView = {
        let view: UIImageView = .init()
        
        view.backgroundColor = .lightGray
        
        return view
    }()
    
    private lazy var noImageTitleLabel: UILabel = {
        let view: UILabel = .init()
        
        view.font = .systemFont(ofSize: .fontSizeSmall, weight: .semibold)
        view.textColor = .darkGray
        view.text = .noImageTitle
        view.textAlignment = .center
        
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view: UILabel = .init()
        
        view.font = .systemFont(ofSize: .fontSizeMedium)
        
        return view
    }()
    
    // MARK: - LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Errors.noInitCoder.description)
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        contentView.addSubviews(titleLabel, iconView, noImageTitleLabel)
        
        iconView.snp.makeConstraints { maker in
            maker.left.equalToSuperview().inset(CGFloat.sizeM)
            maker.top.bottom.equalToSuperview().inset(CGFloat.iconOffset)
            maker.height.width.equalTo(CGFloat.iconWidth)
        }
        
        titleLabel.snp.makeConstraints { maker in
            maker.left.equalTo(iconView.snp.right).offset(CGFloat.iconOffset)
            maker.right.equalToSuperview().inset(CGFloat.sizeM)
            maker.centerY.equalToSuperview()
        }
        
        noImageTitleLabel.snp.makeConstraints { maker in
            maker.centerY.equalTo(iconView)
            maker.left.equalTo(iconView).offset(CGFloat.sizeS)
            maker.right.equalTo(iconView).inset(CGFloat.sizeS)
        }
    }
    
    // MARK: - Public Methods
    
    func dropImage() {
        iconView.image = nil
        iconView.backgroundColor = .systemGray5
        noImageTitleLabel.isHidden = false
    }
    
    func loadImage(for url: URL) {
        dropImage()
        iconView.kf.setImage(with: url, completionHandler: { [weak self] _ in
            self?.iconView.backgroundColor = nil
            self?.noImageTitleLabel.isHidden = true
        })
    }
}

// MARK: - Constants

private extension CGFloat {
    static let iconWidth: CGFloat = 52
    static let iconOffset: CGFloat = 10
}

private extension String {
    static let noImageTitle: String = "Cocktails"
}

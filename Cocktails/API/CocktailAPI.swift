//
//  CocktailAPI.swift
//  Cocktails
//
//  Created by Andrew on 03.05.2022.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

protocol CocktailAPIProtocol {
    func getCategories() -> Observable<[CocktailApiCategory]>
    func getCocktails(for category: String) -> Observable<[CocktailApiDrinkShortInfo]>
}

class CocktailAPI: CocktailAPIProtocol {
    static let mainUrl = "https://www.thecocktaildb.com/api/json/v1"
    static let APIKey = "1"
    
    private static let mainKeyPath: String = "drinks"
    
    private lazy var provider: MoyaProvider<CocktailAPIPaths> = .init()
    
    func getCategories() -> Observable<[CocktailApiCategory]> {
        provider.rx
            .request(.getCategories)
            .map([CocktailApiCategory].self, atKeyPath: Self.mainKeyPath)
            .catchAndReturn([])
            .asObservable()
    }
    
    func getCocktails(for category: String) -> Observable<[CocktailApiDrinkShortInfo]> {
        provider.rx
            .request(.getCocktails(category: category))
            .map([CocktailApiDrinkShortInfo].self, atKeyPath: Self.mainKeyPath)
            .catchAndReturn([])
            .asObservable()
    }
}

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
    func getCategories() -> Observable<[CocktailAPICategory]>
    func getCocktails(for category: String) -> Observable<[CocktailAPIDrinkShortInfo]>
}

class CocktailAPI: CocktailAPIProtocol {
    static let mainURL = "https://www.thecocktaildb.com/api/json/v1"
    static let APIKey = "1"
    
    private static let mainKeyPath: String = "drinks"
    
    private lazy var provider: MoyaProvider<CocktailAPIPaths> = .init()
    
    func getCategories() -> Observable<[CocktailAPICategory]> {
        provider.rx
            .request(.getCategories)
            .map([CocktailAPICategory].self, atKeyPath: Self.mainKeyPath)
            .catchAndReturn([])
            .asObservable()
    }
    
    func getCocktails(for category: String) -> Observable<[CocktailAPIDrinkShortInfo]> {
        provider.rx
            .request(.getCocktails(category: category))
            .map([CocktailAPIDrinkShortInfo].self, atKeyPath: Self.mainKeyPath)
            .catchAndReturn([])
            .asObservable()
    }
}

//
//  CocktailCategoryMocker.swift
//  Cocktails
//
//  Created by Andrew on 30.04.2022.
//

import Foundation

class CocktailCategoryMocker {
    class func generateCategories() -> [CocktailCategory] {
        let urlsString: [String] = [
            "https://dynamic-assets.coinbase.com/afad1ab0520ae7e2d7c1d9792605202f4747295b859286b547a16012a7eabb8dd9b0a2bf67bb039903f85144e793ec86235682fd201c8aa87c9dcd5d2d772da3/asset_icons/65bc09f1093ecbb6e18355951443fd30764364c3afb119ce4611c8bc5ae265bf.png",
            "https://www.acouplecooks.com/wp-content/uploads/2021/03/Yellow-Bird-Cocktail-004.jpg",
            "https://www.thespruceeats.com/thmb/8aCKTFWGiCnoitlH-v8voyiwry4=/3489x3489/smart/filters:no_upscale()/kamikaze-cocktail-recipe-759313-hero-01-755709e3ac474259951edc0870b5b261.jpg"
        ]
        
        let urls: [URL] = urlsString.compactMap { urlString -> URL? in
                .init(string: urlString)
        }
        
        let firstCocktails: [Cocktail] = urls.map { url -> Cocktail in
                .init(name: String(url.absoluteString.prefix(10)), imageUrl: url)
        }
        
        return [.init(name: "Ordinary Drink", cocktails: firstCocktails)]
    }
}

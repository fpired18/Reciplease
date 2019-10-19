//
//  RecipeStruct.swift
//  Reciplease
//
//  Created by Frédéric PICHOT on 13/09/2019.
//  Copyright © 2019 Frédéric PICHOT. All rights reserved.
//

import Foundation

struct RecipeStruct: Decodable {
    let hits: [Hits]
    
    init(hits: [Hits]) {
        self.hits = hits
    }
}

struct Hits: Decodable {
    var recipe: Recipe
}

struct Recipe: Decodable {
    var uri: String
    var label: String
    var image: String
    var source: String
    var url: String
    var ingredientLines:[String]
    var ingredients: [Ingredients]
    var calories: Float
    var totalTime: Float
    var yield: Int
}

struct Ingredients: Decodable {
    var  text: String
    var weight: Double
}

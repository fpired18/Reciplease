//
//  RecipeFavorite.swift
//  Reciplease
//
//  Created by Frédéric PICHOT on 07/10/2019.
//  Copyright © 2019 Frédéric PICHOT. All rights reserved.
//

import Foundation
import CoreData

class RecipeFavorite: NSManagedObject {
    static var all: [RecipeFavorite] {
        let request: NSFetchRequest<RecipeFavorite> = RecipeFavorite.fetchRequest()
        guard let recipes = try? AppDelegate.viewContext.fetch(request) else {
            return []
        }
        return recipes
    }
    
    static func deleteAll() {
        let viewContext = AppDelegate.viewContext
        RecipeFavorite.all.forEach({ viewContext.delete($0) })
        try? viewContext.save()
    }
    
    static func delete(label: String, viewContext: NSManagedObjectContext = AppDelegate.viewContext) {
        let request: NSFetchRequest<RecipeFavorite> = RecipeFavorite.fetchRequest()
        for index in 0..<RecipeFavorite.all.count {
            print("Voici index \(index) et RecipeFavorite.all.count \(RecipeFavorite.all.count)")
            //if index == RecipeFavorite.all.count {
                request.predicate = NSPredicate(format: "label = %@", label)
                guard let record = try? viewContext.fetch(request) else { return }
                guard let recipe = record.first else { return }
                viewContext.delete(recipe)
//            } else if label == RecipeFavorite.all[index].label {
//                request.predicate = NSPredicate(format: "label = %@", label)
//                guard let record = try? viewContext.fetch(request) else { return }
//                guard let recipe = record.first else { return }
//                viewContext.delete(recipe)
//            }
        }
        try? viewContext.save()
    }
    
    static func save(recipe: Recipe, viewContext: NSManagedObjectContext = AppDelegate.viewContext, image: Data) {
        print("Voici le nombre d'enregistrement à l'entrée de save : \(RecipeFavorite.all.count)")
        let recipeFavorite = RecipeFavorite(context: viewContext)
        recipeFavorite.calories = recipe.calories
        recipeFavorite.imageString = recipe.image
        recipeFavorite.label = recipe.label
        recipeFavorite.source = recipe.source
        recipeFavorite.totalTime = recipe.totalTime
        recipeFavorite.url = recipe.url
        recipeFavorite.yield = String(recipe.yield)
        recipeFavorite.imageData = image
        
        for index in 0..<recipe.ingredientLines.count {
            let ingredient = Ingredient(context: AppDelegate.viewContext)
            ingredient.name = recipe.ingredientLines[index]
            ingredient.recipeFavorite = recipeFavorite
        }
        try? viewContext.save()
        print("Voici le nombre d'enregistrement à la sortie de save \(RecipeFavorite.all.count)")
    }
    
    static func recipeAlreadyRecord(label: String,
                                        viewContext: NSManagedObjectContext = AppDelegate.viewContext) -> Bool {
        let request: NSFetchRequest<RecipeFavorite> = RecipeFavorite.fetchRequest()
        request.predicate = NSPredicate(format: "label = %@", label)
        guard let favoriteRecipe = try? viewContext.fetch(request) else { return false }
        if favoriteRecipe.isEmpty {
            return false
        }
        return true
    }
}

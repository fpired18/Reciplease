//
//  Ingredient.swift
//  Reciplease
//
//  Created by Frédéric PICHOT on 24/09/2019.
//  Copyright © 2019 Frédéric PICHOT. All rights reserved.
//

import Foundation
import CoreData

class Ingredient: NSManagedObject {
    static var all: [Ingredient] {
        let request: NSFetchRequest<Ingredient> = Ingredient.fetchRequest()
        guard let ingredients = try? AppDelegate.viewContext.fetch(request) else {
            return []
        }
        return ingredients
    }
}



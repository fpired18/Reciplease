//
//  RecipeService.swift
//  Reciplease
//
//  Created by Frédéric PICHOT on 13/09/2019.
//  Copyright © 2019 Frédéric PICHOT. All rights reserved.
//

import Foundation // COUCOU
import Alamofire
import SwiftyJSON

class RecipeService {
    var hits: [Hits] = []
    static let recipeUrl = "https://api.edamam.com/search"
    
    private let recipeSession: RecipeProtocol
    
    init(recipeSession: RecipeProtocol = RecipeSession()) {
        self.recipeSession = recipeSession
    }
    
    func getRecipe(valueEntered: String, completionHandler: @escaping (Bool, RecipeStruct?) -> Void) {
        
        guard let completeUrl = URL(string: RecipeService.recipeUrl + "?q=" + valueEntered + "&app_id=" + RecipeApp.app_id + "&app_key=" + RecipeApp.app_Key) else {
            return
        }
        print("Voici l'adresse complète \(completeUrl)")
        
            self.recipeSession.request(url: completeUrl) { response in
                switch response.result {
                case .success:
                    guard response.response?.statusCode == 200 else {
                        completionHandler(false, nil)
                        return
                    }
                    guard let data = response.data, response.error == nil else {
                        completionHandler(false, nil)
                        return
                    }
                    guard let recipeResponse = try? JSONDecoder().decode(RecipeStruct.self, from: data) else {
                        completionHandler(false, nil)
                        return
                    }
                    completionHandler(true, recipeResponse)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    static func timePreparation(preparationTime: Float) -> String {
        let hourMinute: Float = 60.0
        var display = ""
        if preparationTime > hourMinute {
            let preparationTimeInt = Int(preparationTime)
            let timePreparationHours = preparationTimeInt / Int(hourMinute)
            let restOfDivision = preparationTimeInt % Int(hourMinute)
            display = "\(timePreparationHours)" + "h" + "\(restOfDivision) m"
        }
        else {
            display = String(format: "%.0f", preparationTime) + "m"
        }
        return display
    }
    
    
    static func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
}


//
//  DetailRecipeViewController.swift
//  Reciplease
//
//  Created by Frédéric PICHOT on 17/09/2019.
//  Copyright © 2019 Frédéric PICHOT. All rights reserved.
//

import UIKit

class DetailRecipeViewController: UIViewController {

    //@IBOutlet weak var saveRecipeButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var kiloCaloriesLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var getDirectionButton: UIButton!
    @IBOutlet weak var titleRecipeLabel: UILabel!
    @IBOutlet weak var imageRecipe: UIImageView!
    @IBOutlet weak var ingredientsList: UITextView!
    @IBOutlet weak var littleView: UIView!
    
    var hourMinute: Float = 60.0
    var imageDownload: Data?
    var recipe: Recipe?
    var recipeFavorite: RecipeFavorite!
    var ingredients = Ingredient.all
    var origineData = false
    var button = UIButton()
    
    @IBAction func tappeGetDirectionButton(_ sender: Any) {
        if origineData {
            if let recipeUrlData = recipeFavorite.url {
                UIApplication.shared.open(NSURL(string: recipeUrlData)! as URL)
            }
        } else {
            if let recipeUrl = recipe?.url {
                UIApplication.shared.open(NSURL(string: recipeUrl)! as URL)
            }
        }
    }
    
    @IBAction func tappeSaveRecipe(_ sender: Any) {
        if origineData {
            if let recipe = recipeFavorite {
                button.setImage(UIImage (named: "Image-2"), for: .normal)
                RecipeFavorite.delete(label: recipe.label!)
            }
        } else {
            saveRecipe()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 40)
        button.setImage(UIImage (named: "Image-1"), for: .normal)
        button.addTarget(self, action: #selector(tappeSaveRecipe), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
        getDirectionButton.layer.cornerRadius = 8
        toggleActivityIndicator(shown: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ingredients = Ingredient.all
        if origineData {
            print("Voici ce que j'ai reçu \(String(describing: recipeFavorite))")
            button.setImage(UIImage (named: "Image-1"), for: .normal)
            displayRecipeData()
        } else {
            print("\n--------------------------------------------------")
            print("DetailRecipeViewController et RecipeFavorite.all.count = \(RecipeFavorite.all.count) Ligne 69 ")
            button.setImage(UIImage (named: "Image-2"), for: .normal)
            displayRecipeDownload()
        }
    }
    
    private func saveRecipe() {
        if RecipeFavorite.recipeAlreadyRecord(label: recipe!.label) {
            presentAlert(message: "This recipe was already record")
        } else {
            print("DetailRecipeViewController et RecipeFavorite.all.count = \(RecipeFavorite.all.count) Ligne 82 ")
            button.setImage(UIImage (named: "Image-1"), for: .normal)
            if let image = imageDownload {
                print("DetailRecipeViewController et RecipeFavorite.all.count = \(RecipeFavorite.all.count) Ligne 86 ")
                RecipeFavorite.save(recipe: recipe!, image: image)
                print("DetailRecipeViewController et RecipeFavorite.all.count = \(RecipeFavorite.all.count) Ligne 87 ")
            }
        }
    }
    
    func displayRecipeDownload() {
        if let recipe = recipe {
            titleRecipeLabel.text = recipe.source
            kiloCaloriesLabel.text = String(format: "%.0f", recipe.calories / 1000) + "K"
            if recipe.totalTime > hourMinute {
                self.timeLabel.text = RecipeService.timePreparation(preparationTime: recipe.totalTime)
            }
            for index in 0..<recipe.ingredientLines.count {
                ingredientsList.text += "- " + recipe.ingredientLines[index] + "\n"
            }
            imageDownload = try! Data(contentsOf: URL(string: recipe.image)!)
            if let image = imageDownload {
                imageRecipe.image = UIImage(data: image)
            }
        }
    }
    
    func displayRecipeData() {
        titleRecipeLabel.text = recipeFavorite.label
        kiloCaloriesLabel.text = String(format: "%.0f", recipeFavorite.calories / 1000) + "K"
        
        self.timeLabel.text = RecipeService.timePreparation(preparationTime: recipeFavorite.totalTime)
        
        if let ingredientsListeData = recipeFavorite.ingredients?.allObjects as? [Ingredient] {
            for index in 0..<ingredientsListeData.count {
                ingredientsList.text += "- " + "\(ingredientsListeData[index].name!)" + "\n"
            }
        }
        if let imageData = recipeFavorite.imageData {
            imageRecipe.image = UIImage(data: imageData)
        }
    }
    
    private func toggleActivityIndicator (shown: Bool) {
        getDirectionButton.isHidden = shown
        activityIndicator.isHidden = !shown
        if shown {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
}

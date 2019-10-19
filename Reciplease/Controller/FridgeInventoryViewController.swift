//
//  FridgeInventoryViewController.swift
//  Reciplease
//
//  Created by Frédéric PICHOT on 13/09/2019.
//  Copyright © 2019 Frédéric PICHOT. All rights reserved.
//

import UIKit

class FridgeInventoryViewController: UIViewController {
    
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var searchRecipeButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var enterIngredientTextField: UITextField!
    @IBOutlet weak var listeIngredientListUITextView: UITextView!
    
    var recipes = [Recipe]()
    let recipeService = RecipeService()
    var valueEntered = ""
    
    @IBAction func tappeAddButton(_ sender: Any) {
        controleSeizure()
        enterIngredientTextField.text = ""
        enterIngredientTextField.resignFirstResponder()
    }
    
    @IBAction func tappeClearButton(_ sender: Any) {
        listeIngredientListUITextView.text = ""
        valueEntered = ""
    }
    
    @IBAction func tappeSearchRecipesButton(_ sender: Any) {
        searchRecipes()
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        enterIngredientTextField.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearButton.isHidden = false
        toggleActivityIndicator(shown: false)
        searchRecipeButton.layer.cornerRadius = 8
        addButton.layer.cornerRadius = 8
        clearButton.layer.cornerRadius = 8
        enterIngredientTextField.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor
        enterIngredientTextField.layer.shadowRadius = 2.0
        enterIngredientTextField.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        enterIngredientTextField.layer.shadowOpacity = 2.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        toggleActivityIndicator(shown: false)
    }
    
    private func toggleActivityIndicator (shown: Bool) {
        searchRecipeButton.isHidden = shown
        activityIndicator.isHidden = !shown
        if shown {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    func controleSeizure()  {
        guard let ingredient = enterIngredientTextField.text else { return }
        if ingredient != "" && ingredient != "´" {
            listeIngredientListUITextView.text += "- " + ingredient + "\n"
            valueEntered += ingredient.trimmingCharacters(in: .whitespacesAndNewlines) + ","
        } else {
            presentAlert(message: "You haven't entered an ingredient !")
        }
    }
    
    private func searchRecipes() {
        if listeIngredientListUITextView.text != "" {
            clearButton.isHidden = true
            toggleActivityIndicator(shown: true)
            
            recipeService.getRecipe(valueEntered: valueEntered) { (success, recipeStructs) in
                if success {
                    if (recipeStructs?.hits.isEmpty)! {
                        self.presentAlert(message: "The name of an ingredient is incorrect")
                    } else {
                        for index in 0..<recipeStructs!.hits.count {
                            self.recipes.append(recipeStructs!.hits[index].recipe)
                        }
                        self.performSegue(withIdentifier: "ShowList", sender: self)
                    }
                } else {
                    self.presentAlert(message: "The download failed today!")
                }
            }
        } else {
            presentAlert(message: "The ingredients' liste is empty !")
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowList" {
            let VCDestination = segue.destination as! ListeViewController
            VCDestination.recipes = recipes
        }
    }
}

//
//  ListeViewController.swift
//  Reciplease
//
//  Created by Frédéric PICHOT on 14/09/2019.
//  Copyright © 2019 Frédéric PICHOT. All rights reserved.
//

import UIKit

class ListeViewController: UIViewController {
    
    @IBOutlet weak var recipeTableView: UITableView!
    
    var recipes = [Recipe]()
    var selectedRow : IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        recipeTableView.reloadData()
        print("\n--------------------------------------------------")
        print("ListeViewController RecipeFavorite.all.count = \(RecipeFavorite.all.count) Ligne 29")
        navigationController?.navigationBar.isHidden = false
        if selectedRow != nil {
            recipeTableView.deselectRow(at: selectedRow!, animated: false)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            if let destinationVC = segue.destination as? DetailRecipeViewController {
                if let row = self.recipeTableView.indexPathForSelectedRow?.row {
                    let recipeToSend = recipes[row]
                    destinationVC.recipe = recipeToSend
                }
            }
        }
    }
}

extension ListeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return recipes.count
    }
    
    // - A la selection d'une cellule
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath
        performSegue(withIdentifier: "ShowDetail", sender: self)
    }
    
    // - Création et Insertion d'une cellule dans la tableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PresentCell", for: indexPath) as? PresentTableViewCell
        cell!.configure(recipe: self.recipes[indexPath.row])
        return cell!
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            recipes.remove(at: indexPath.row)
            recipeTableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

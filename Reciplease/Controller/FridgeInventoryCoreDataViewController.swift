//
//  FridgeInventoryCoreDataViewController.swift
//  Reciplease
//
//  Created by Frédéric PICHOT on 27/09/2019.
//  Copyright © 2019 Frédéric PICHOT. All rights reserved.
//
import UIKit
import CoreData

class FridgeInventoryCoreDataViewController: UIViewController {
    
    @IBOutlet weak var dataTableView: UITableView!

    var recipeFavorite = RecipeFavorite.all
    var selectedRow : IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
//           self.parent?.parent?.dismiss(animated: true, completion: nil)
//        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
//        self.navigationController?.popViewController(animated: true)
//        self.view.window?.rootViewController?.presentedViewController!.dismiss(animated: true, completion: nil)
        DispatchQueue.main.async {
            self.dataTableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.dismiss(animated: true, completion: nil)
        super.viewWillAppear(animated)
        
        recipeFavorite = RecipeFavorite.all
        if recipeFavorite.count >= 0 {
            dataTableView.reloadData()
            print("\n--------------------------------------------------")
            print("FridgeInventoryCoreDataViewController RecipeFavorite.all.count = \(RecipeFavorite.all.count) ligne 32 ")
        }
        if recipeFavorite.count == 0 {
            presentAlert(message: "Your list is empty !")
        }
    }
    
    func refreshView() {
        self.viewDidLoad()
    }
    
    @IBAction func tappeDeletedAll(_ sender: Any) {
        print("\n--------------------------------------------------")
        print("FridgeInventoryCoreDataViewController RecipeFavorite.all.count = \(RecipeFavorite.all.count) Ligne 44 ")
        RecipeFavorite.deleteAll()
        recipeFavorite = RecipeFavorite.all
        dataTableView.reloadData()
    }
}

extension FridgeInventoryCoreDataViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("\n--------------------------------------------------")
        print("FridgeInventoryCoreDataViewController RecipeFavorite.all.count = \(RecipeFavorite.all.count) Ligne 59 ")
        return recipeFavorite.count
    }
    
    // - A la selection d'une cellule
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\n--------------------------------------------------")
        print("FridgeInventoryCoreDataViewController RecipeFavorite.all.count = \(RecipeFavorite.all.count) Ligne 66 ")
        selectedRow = indexPath
        performSegue(withIdentifier: "ShowDetailData", sender: self)
    }
    
    // - Création et Insertion d'une cellule dans la tableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("\n--------------------------------------------------")
        print("FridgeInventoryCoreDataViewController RecipeFavorite.all.count = \(RecipeFavorite.all.count) Ligne 74 ")
        let cell = tableView.dequeueReusableCell(withIdentifier: "PresentDataCell", for: indexPath) as? PresentDataTableViewCell
        cell?.configureFavorite(recipeFavorite: recipeFavorite[indexPath.row])
        return cell!
    }
    
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            print("\n--------------------------------------------------")
            print("FridgeInventoryCoreDataViewController RecipeFavorite.all.count = \(RecipeFavorite.all.count) Ligne 82 ")
            if editingStyle == .delete {
                if let record = recipeFavorite[indexPath.row].label {
                    recipeFavorite.remove(at: indexPath.row)
                    RecipeFavorite.delete(label: record)
                    self.recipeFavorite = RecipeFavorite.all
                    dataTableView.deleteRows(at: [indexPath], with: .automatic)
                }
            }
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("\n--------------------------------------------------")
        print("FridgeInventoryCoreDataViewController Ligne 95 ")
        if segue.identifier == "ShowDetailData" {
            if let destinationVC = segue.destination as? DetailRecipeViewController {
                if let row = self.dataTableView.indexPathForSelectedRow?.row {
                    print("\nVOICI ROW !!!!!!!!!!!! \(row)!!!!!!!!!!!!!!!")
                    let recipeToSendData = recipeFavorite[row]
                    destinationVC.origineData = true
                    destinationVC.recipeFavorite = recipeToSendData
                }
            }
        }
    }
}

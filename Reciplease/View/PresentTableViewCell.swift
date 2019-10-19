//
//  PresentTableViewCell.swift
//  Reciplease
//
//  Created by Frédéric PICHOT on 15/09/2019.
//  Copyright © 2019 Frédéric PICHOT. All rights reserved.
//

import UIKit

class PresentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var kiloCalorieLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageViewCell: UIImageView!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var whiteView: UIView!
    
    var hourMinute: Float = 60.0
    var imageDownload: Data?
    
    func configure(recipe: Recipe) {
        self.titleLabel.text = recipe.source
        self.sourceLabel.text = recipe.label
        self.kiloCalorieLabel.text = String(format: "%.0f", recipe.calories / 1000) + "K"
        if recipe.totalTime > self.hourMinute {
            self.timeLabel.text = RecipeService.timePreparation(preparationTime: recipe.totalTime)
        } else {
            if recipe.totalTime == 0 {
                self.timeLabel.text = ""
            } else {
                self.timeLabel.text = String(recipe.totalTime)
            }
        }
        imageDownload = try! Data(contentsOf: URL(string: recipe.image)!)
        if let image = imageDownload {
            if let picture = UIImage(data: image) {
                imageViewCell.image = RecipeService.resizeImage(image: picture, targetSize: CGSize.init(width: 200, height: 200))
            }
        }
    }
}

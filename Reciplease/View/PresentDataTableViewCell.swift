//
//  PresentDataTableViewCell.swift
//  Reciplease
//
//  Created by Frédéric PICHOT on 08/10/2019.
//  Copyright © 2019 Frédéric PICHOT. All rights reserved.
//

import UIKit

class PresentDataTableViewCell: UITableViewCell {
    
    @IBOutlet weak var kiloCalorieLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageViewCell: UIImageView!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var whiteView: UIView!
    
    var hourMinute: Float = 60.0
    var imageDownload: Data?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addShadow()
    }
    
    private func addShadow() {
        whiteView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor
        whiteView.layer.shadowRadius = 8.0
        whiteView.layer.shadowOffset = CGSize(width: 8.0, height: 8.0)
        whiteView.layer.shadowOpacity = 8.0
    }
    
    func configureFavorite(recipeFavorite: RecipeFavorite) {
        if let image = recipeFavorite.imageData {
            imageViewCell.image = UIImage(data: image)
        }
        titleLabel.text = recipeFavorite.source
        sourceLabel.text = recipeFavorite.label
        kiloCalorieLabel.text = String(format: "%.0f", recipeFavorite.calories / 1000) + "K"
        if recipeFavorite.totalTime > self.hourMinute {
            timeLabel.text = RecipeService.timePreparation(preparationTime: recipeFavorite.totalTime)
        } else {
            if recipeFavorite.totalTime == 0 {
                timeLabel.text = "0"
            } else {
                timeLabel.text = String(recipeFavorite.totalTime)
            }
        }
    }
}

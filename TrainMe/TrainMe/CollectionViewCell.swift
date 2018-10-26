//
//  CollectionViewCell.swift
//  TrainMe
//
//  Created by Арсений Живаго on 19.09.2018.
//  Copyright © 2018 Арсений Живаго. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var CellLabel: UILabel!
    @IBOutlet weak var MyImage: UIImageView!
    @IBOutlet weak var caloriesLabel: UILabel!
    override func awakeFromNib() {
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 4.0
        self.layer.masksToBounds = false
        self.MyImage.contentMode = .scaleAspectFill
        self.MyImage.layer.cornerRadius = 10
        self.MyImage.layer.masksToBounds = true
        self.MyImage.layer.cornerRadius = MyImage.frame.height/2
    }
    
}

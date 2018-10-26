//
//  TrainingCollectionViewCell.swift
//  TrainMe
//
//  Created by Арсений Живаго on 21.09.2018.
//  Copyright © 2018 Арсений Живаго. All rights reserved.
//

import UIKit

class TrainingCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var NameLabel: UILabel!
    override func awakeFromNib() {
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 4.0
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.brown.cgColor
//        borderView.layer.borderWidth = 3.0
//        borderView.layer.borderColor = UIColor.brown.cgColor
        self.layer.borderWidth = 2.0
    
    }
}

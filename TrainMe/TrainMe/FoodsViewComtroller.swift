//
//  FoodsViewComtroller.swift
//  TrainMe
//
//  Created by Арсений Живаго on 19.09.2018.
//  Copyright © 2018 Арсений Живаго. All rights reserved.
//

import UIKit

class FoodsViewComtroller: UIViewController {
    
    var foodName: String?
    var labelText: String?
    var imageForView: UIImage?
    
    
    
    @IBOutlet weak var FoodName: UILabel!
    @IBOutlet weak var FoodScrollView: UIScrollView!
    
    @IBOutlet var FoodView: UIView!
    @IBOutlet weak var FoodViewImage: UIImageView!
    @IBOutlet weak var FoodViewLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FoodViewLabel.text = labelText
        FoodViewLabel.sizeToFit()
        FoodViewImage.image = imageForView
        FoodName.text = foodName
        FoodViewImage.layer.cornerRadius = 10
        FoodViewImage.layer.shadowColor = UIColor.black.cgColor
        FoodViewImage.layer.shadowOffset = CGSize(width: 4, height: 4)
        FoodViewImage.layer.shadowOpacity = 0.4
        FoodViewImage.layer.shadowRadius = 4.0
        FoodViewImage.layer.masksToBounds = false
        var contentRect = CGRect.zero
        
        for view in FoodScrollView.subviews {
            contentRect = contentRect.union(view.frame)
        }
        FoodScrollView.contentSize = contentRect.size
        print(contentRect.size)
    }
    
//    static func update(_ name: String,_ imageName: String,_ recipe: String) -> FoodsViewComtroller{
//        let newViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "IdentifierOfYouViewController") as! FoodsViewComtroller
//        
//        newViewController.FoodViewLabel.text = name + "\n" + recipe
//        newViewController.FoodViewImage.image = UIImage(named: imageName)
//        return newViewController
//    }
    
}

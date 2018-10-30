//
//  ExerciseViewController.swift
//  TrainMe
//
//  Created by Арсений Живаго on 29/10/2018.
//  Copyright © 2018 Арсений Живаго. All rights reserved.
//

import UIKit

class ExerciseViewController: UIViewController {

    @IBOutlet weak var ExerciseName: UILabel!
    @IBOutlet weak var ExerciseTime: UILabel!
    @IBOutlet weak var DeleteButton: UIButton!

    @IBOutlet weak var GradientLine: UIView!
    
    var indexOfExercise: Int?
    var Name: String!
    var Time: String!
    var NiceTime = ""
    
    
    @IBAction func DeletingExercise(_ sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ExerciseTime.text = Time
        ExerciseName.text = Name
        
        DeleteButton.layer.cornerRadius = DeleteButton.frame.height/2
        DeleteButton.layer.shadowColor = UIColor.black.cgColor
        DeleteButton.layer.shadowOffset = CGSize(width: 1, height: 2)
        DeleteButton.layer.shadowOpacity = 0.3
        DeleteButton.layer.shadowRadius = 4.0
        DeleteButton.layer.masksToBounds = false
        if(Int(Time)!/1200 < 10 ){
            NiceTime += "0\(Int(Time)!/1200):"
        } else {
            NiceTime += "\(Int(Time)!/1200):"
        }
        if((Int(Time)!%1200)/60 < 10 ){
            NiceTime += "0\((Int(Time)!%1200)/60):"
        } else {
            NiceTime += "\((Int(Time)!%1200)/60):"
        }
        if(((Int(Time)!%1200)%60) < 10 ){
            NiceTime += "0\(((Int(Time)!%1200)%60))"
        } else {
            NiceTime += "\(((Int(Time)!%1200)%60))"
        }
        ExerciseTime.text = NiceTime
        
        createGradientLayer(for: GradientLine)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func createGradientLayer(for view: UIView) {
        let gradientLayer: CAGradientLayer
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor(red:0, green:0.49, blue: 1.0, alpha: 1).cgColor, UIColor(red:0.58, green:0.75, blue:1, alpha: 1).cgColor,UIColor(red:0, green:0.49, blue: 1.0, alpha: 1).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0,y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1,y: 0.5)
        view.layer.addSublayer(gradientLayer)
    }

}

//
//  NewExerciseViewController.swift
//  TrainMe
//
//  Created by Арсений Живаго on 27/10/2018.
//  Copyright © 2018 Арсений Живаго. All rights reserved.
//

import UIKit

class NewExerciseViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    

    @IBOutlet weak var SaveButton: UIButton!
    @IBOutlet weak var GradientLine: UIView!
    @IBOutlet weak var ExerciseNameTextField: UITextField!
    @IBOutlet weak var HoursTextField: UITextField!
    @IBOutlet weak var MinutesTextField: UITextField!
    @IBOutlet weak var SecondsTextField: UITextField!
    
 
    
    let SecAndMin = [["0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23"],["0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59"],["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59"]]
   // let hours = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23"]
    
    var selectedTime = ["0","0","1"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createGradientLayer(for: GradientLine)
        createSecondPicker()
        
        SaveButton.layer.cornerRadius = SaveButton.frame.width/2
        SaveButton.layer.shadowColor = UIColor.black.cgColor
        SaveButton.layer.shadowOffset = CGSize(width: 1, height: 2)
        SaveButton.layer.shadowOpacity = 0.3
        SaveButton.layer.shadowRadius = 4.0
        SaveButton.layer.masksToBounds = false
       
        // Do any additional setup after loading the view.
    }
    

    
    func createSecondPicker(){
        let TimePicker = UIPickerView()
        TimePicker.delegate = self
        
        MinutesTextField.inputView = TimePicker
        HoursTextField.inputView = TimePicker
        SecondsTextField.inputView = TimePicker

    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return SecAndMin[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return SecAndMin[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedTime[component] = SecAndMin[component][row]
        
        SecondsTextField.text = selectedTime[2]
        MinutesTextField.text = selectedTime[1]
        HoursTextField.text = selectedTime[0]
    }
    
    func createGradientLayer(for view: UIView) {
        let gradientLayer: CAGradientLayer
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor(red:0, green:0.49, blue: 1.0, alpha: 1).cgColor, UIColor(red:0.58, green:0.75, blue:1, alpha: 1).cgColor,UIColor(red:0, green:0.49, blue: 1.0, alpha: 1).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0,y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1,y: 0.5)
        view.layer.addSublayer(gradientLayer)
    }
    
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return SecAndMin.count
//    }
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return SecAndMin[row]
//    }
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        selectedSec = SecAndMin[row]
//        SecondsTextField.text = selectedSec
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

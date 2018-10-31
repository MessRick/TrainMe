 //
//  TrainigsViewController.swift
//  TrainMe
//
//  Created by Арсений Живаго on 21.09.2018.
//  Copyright © 2018 Арсений Живаго. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox
import SQLite3

class TrainigsViewController: UIViewController {
    
    var labelName: String?
    var exerciseNameDefaulte: String = ""
    var exerciseTimeDefaulte: String = ""
    var exerciseName:[String] = []
    var timerSec:[String] = []
    var HousTime: Int = 0
    var MinutesTime: Int = 0
    var SecondsTime: Int = 0
    var hours = ""
    var minutes = ""
    var seconds = ""
    var timer = Timer()
    var i = 0
    var isTrainingEditing = false
    var colotNow: UIColor?
    var indexItem: Int?
    var NiceTime = ""
    var isTrainingGoing =  false
    var isSarted = false

    @IBOutlet weak var EditButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var LineAfterNameOfTraining: UIView!
    @IBOutlet weak var TrainingNameLabel: UILabel!
    @IBOutlet weak var ExerciseNameLabel: UILabel!
    @IBOutlet weak var TimerLabel: UILabel!
    @IBOutlet weak var StartButtonSelf: UIButton!
    
    @IBAction func EditingAction(_ sender: UIButton) {
        isTrainingEditing = !isTrainingEditing
        
        if(isTrainingEditing){
            deleteButton.isHidden = false
            EditButton.setTitle("done", for: .normal)
            
        } else {
            deleteButton.isHidden = true
            EditButton.setTitle("edit", for: .normal)
        }
        
    }
    
    @IBAction func deleteAction(_ sender: UIButton) {
      
    }
    
  
    
    @IBAction func StartButton(_ sender: UIButton) {
        if(!isSarted){
            isSarted = true
            StartButtonSelf.setTitle("Pause", for: .normal)
            StartButtonSelf.tintColor = .red
            StartButtonSelf.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold",size: 34)
            HousTime = Int(timerSec[i])!/1200
            MinutesTime = (Int(timerSec[i])!%1200)/60
            SecondsTime = ((Int(timerSec[i])!%1200)%60)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
            isTrainingGoing = !isTrainingGoing
        }else{
        
        if(!isTrainingGoing){
        isTrainingGoing = !isTrainingGoing
        timer.invalidate()
        StartButtonSelf.setTitle("Pause", for: .normal)
        StartButtonSelf.tintColor = .red
        StartButtonSelf.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold",size: 34)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)

        } else {
            timer.invalidate()
            StartButtonSelf.setTitle("Start", for: .normal)
            StartButtonSelf.tintColor = colotNow
             StartButtonSelf.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold",size: 40)
            isTrainingGoing = !isTrainingGoing
        }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        colotNow = EditButton.currentTitleColor
        
        TrainingNameLabel.text = labelName
        exerciseName = exerciseNameDefaulte.components(separatedBy: ",")
        timerSec = exerciseTimeDefaulte.components(separatedBy: ",")
        exerciseName.removeLast()
        timerSec.removeLast()
        
        ExerciseNameLabel.text = exerciseName[0]
        MakeThisTimeNiceAgain(timerSec[i],timerSec[i],timerSec[i])
        TimerLabel.text = NiceTime
        
        createGradientLayer(for: LineAfterNameOfTraining)
        StartButtonSelf.layer.cornerRadius = StartButtonSelf.frame.width/2
        StartButtonSelf.layer.shadowColor = UIColor.black.cgColor
        StartButtonSelf.layer.shadowOffset = CGSize(width: 1, height: 2)
        StartButtonSelf.layer.shadowOpacity = 0.3
        StartButtonSelf.layer.shadowRadius = 4.0
        StartButtonSelf.layer.masksToBounds = false
        
       // EditButton.titleLabel?.text = "edit"
        EditButton.layer.cornerRadius = EditButton.frame.height/2
        EditButton.layer.shadowColor = UIColor.black.cgColor
        EditButton.layer.shadowOffset = CGSize(width: 1, height: 2)
        EditButton.layer.shadowOpacity = 0.3
        EditButton.layer.shadowRadius = 4.0
        EditButton.layer.masksToBounds = false
        
        deleteButton.isHidden = true
        deleteButton.layer.cornerRadius = deleteButton.frame.height/2
        deleteButton.layer.shadowColor = UIColor.black.cgColor
        deleteButton.layer.shadowOffset = CGSize(width: 1, height: 2)
        deleteButton.layer.shadowOpacity = 0.3
        deleteButton.layer.shadowRadius = 4.0
        deleteButton.layer.masksToBounds = false
        // Do any additional setup after loading the view.
    }
    
    
    func MakeThisTimeNiceAgain(_ Hours: String!,_ Minutes: String!,_ Seconds: String!){
        NiceTime = ""
        if(Int(Hours)!/1200 < 10 ){
            NiceTime += "0\(Int(Hours)!/1200):"
        } else {
            NiceTime += "\(Int(Hours)!/1200):"
        }
        if((Int(Minutes)!%1200)/60 < 10 ){
            NiceTime += "0\((Int(Minutes)!%1200)/60):"
        } else {
            NiceTime += "\((Int(Minutes)!%1200)/60):"
        }
        if(((Int(Seconds)!%1200)%60) < 10 ){
            NiceTime += "0\(((Int(Seconds)!%1200)%60))"
        } else {
            NiceTime += "\(((Int(Seconds)!%1200)%60))"
        }
    }
    
    @objc func timerAction() {
        
        if SecondsTime == 0 && MinutesTime == 0 && HousTime == 0 && i+1 < exerciseName.count{
            
            AudioServicesPlaySystemSound(SystemSoundID(1308))
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            i+=1
            HousTime = 0
            MinutesTime = 0
            SecondsTime = 0
            HousTime = Int(timerSec[i])!/1200
            MinutesTime = (Int(timerSec[i])!%1200)/60
            SecondsTime = ((Int(timerSec[i])!%1200)%60)
            ExerciseNameLabel.text = exerciseName[i]
            MakeThisTimeNiceAgain(String(timerSec[i]),String(timerSec[i]),String(timerSec[i]))
            TimerLabel.text = NiceTime
        } else if i+1 == exerciseName.count && SecondsTime == 0 && MinutesTime == 0 && HousTime == 0{
            AudioServicesPlaySystemSound(SystemSoundID(1330))
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            timer.invalidate()
            i = 0
            HousTime = Int(timerSec[i])!/1200
            MinutesTime = (Int(timerSec[i])!%1200)/60
            SecondsTime = ((Int(timerSec[i])!%1200)%60)
            ExerciseNameLabel.text = exerciseName[i]
            MakeThisTimeNiceAgain(timerSec[i],timerSec[i],timerSec[i])
            TimerLabel.text = NiceTime
            StartButtonSelf.setTitle("Start", for: .normal)
            StartButtonSelf.tintColor = colotNow
            isTrainingGoing = !isTrainingGoing
            
        } else if SecondsTime == 0 {
            if(MinutesTime>0){
                SecondsTime = 59
                MinutesTime -= 1
            } else if (HousTime>0){
                MinutesTime = 59
                SecondsTime = 59
                HousTime -= 1
            }
            MakeThisTimeNiceAgain(String(HousTime*1200),String(MinutesTime*60),String(SecondsTime))
            TimerLabel.text = NiceTime
            
        } else {
        SecondsTime -= 1
            MakeThisTimeNiceAgain(String(HousTime*1200),String(MinutesTime*60),String(SecondsTime))
            TimerLabel.text = NiceTime
        }
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
}

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

class TrainigsViewController: UIViewController {
    
    var labelName: String?
    var exerciseNameDefaulte: String = ""
    var exerciseTimeDefaulte: String = ""
    var exerciseName:[String] = []
    var timerSec:[String] = []
    var HousTime: Int = 0
    var MinutesTime: Int = 0
    var SecondsTime: Int = 0
    var timer = Timer()
    var i = 0

    @IBOutlet weak var LineAfterNameOfTraining: UIView!
    @IBOutlet weak var TrainingNameLabel: UILabel!
    @IBOutlet weak var ExerciseNameLabel: UILabel!
    @IBOutlet weak var TimerLabel: UILabel!
    @IBOutlet weak var StartButtonSelf: UIButton!
    
    @IBAction func StartButton(_ sender: UIButton) {
        timer.invalidate()
        HousTime = Int(timerSec[i])!/1200
        MinutesTime = (Int(timerSec[i])!%1200)/60
        SecondsTime = ((Int(timerSec[i])!%1200)%60)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        TrainingNameLabel.text = labelName
        exerciseName = exerciseNameDefaulte.components(separatedBy: ",")
        timerSec = exerciseTimeDefaulte.components(separatedBy: ",")
        exerciseName.removeLast()
        timerSec.removeLast()
        
        ExerciseNameLabel.text = exerciseName[0]
        TimerLabel.text = "\(Int(timerSec[i])!/1200):\((Int(timerSec[i])!%1200)/60):\(((Int(timerSec[i])!%1200)%60))"
        
        createGradientLayer(for: LineAfterNameOfTraining)
        StartButtonSelf.layer.cornerRadius = StartButtonSelf.frame.width/2
        StartButtonSelf.layer.shadowColor = UIColor.black.cgColor
        StartButtonSelf.layer.shadowOffset = CGSize(width: 1, height: 2)
        StartButtonSelf.layer.shadowOpacity = 0.3
        StartButtonSelf.layer.shadowRadius = 4.0
        StartButtonSelf.layer.masksToBounds = false
        // Do any additional setup after loading the view.
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
            TimerLabel.text = timerSec[i]
        } else if i+1 == exerciseName.count && SecondsTime == 0 && MinutesTime == 0 && HousTime == 0{
            AudioServicesPlaySystemSound(SystemSoundID(1330))
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            timer.invalidate()
            i = 0
            HousTime = Int(timerSec[i])!/1200
            MinutesTime = (Int(timerSec[i])!%1200)/60
            SecondsTime = ((Int(timerSec[i])!%1200)%60)
            ExerciseNameLabel.text = exerciseName[i]
            TimerLabel.text = timerSec[i]
            
        } else if SecondsTime == 0 {
            if(MinutesTime>0){
                SecondsTime = 59
                MinutesTime -= 1
            } else if (HousTime>0){
                MinutesTime = 59
                SecondsTime = 59
                HousTime -= 1
            }
            TimerLabel.text = "\(HousTime):\(MinutesTime):\(SecondsTime)"
            
        } else {
        SecondsTime -= 1
            TimerLabel.text = "\(HousTime):\(MinutesTime):\(SecondsTime)"
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

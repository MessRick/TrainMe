 //
//  TrainigsViewController.swift
//  TrainMe
//
//  Created by Арсений Живаго on 21.09.2018.
//  Copyright © 2018 Арсений Живаго. All rights reserved.
//

import UIKit

class TrainigsViewController: UIViewController {
    
    var labelName: String?
    var exerciseNameDefaulte: String = ""
    var exerciseTimeDefaulte: String = ""
    var exerciseName:[String] = []
    var timerSec:[String] = []
    var setTime: Int = 0
    var timer = Timer()
    var i = 0

    @IBOutlet weak var TrainingNameLabel: UILabel!
    @IBOutlet weak var ExerciseNameLabel: UILabel!
    @IBOutlet weak var TimerLabel: UILabel!
    @IBOutlet weak var StartButtonSelf: UIButton!
    
    @IBAction func StartButton(_ sender: UIButton) {
        timer.invalidate()
        setTime = Int(timerSec[i])!
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
        TimerLabel.text = timerSec[0]
        
     
        StartButtonSelf.layer.cornerRadius = 10
        StartButtonSelf.layer.shadowColor = UIColor.black.cgColor
        StartButtonSelf.layer.shadowOffset = CGSize(width: 2, height: 2)
        StartButtonSelf.layer.shadowOpacity = 0.2
        StartButtonSelf.layer.shadowRadius = 4.0
        StartButtonSelf.layer.masksToBounds = false
        // Do any additional setup after loading the view.
    }
    @objc func timerAction() {
        if setTime == 0 && i+1 < exerciseName.count{
            i+=1
            setTime = Int(timerSec[i])!
            ExerciseNameLabel.text = exerciseName[i]
            TimerLabel.text = timerSec[i]
        } else if i+1 == exerciseName.count && setTime == 0{
            timer.invalidate()
            i = 0
            setTime = Int(timerSec[i])!
            ExerciseNameLabel.text = exerciseName[i]
            TimerLabel.text = timerSec[i]
        } else {
        setTime-=1
        TimerLabel.text = "\(setTime)"
        }
    }
}
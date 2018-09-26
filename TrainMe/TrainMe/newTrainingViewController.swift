//
//  newTrainingViewController.swift
//  TrainMe
//
//  Created by Арсений Живаго on 24.09.2018.
//  Copyright © 2018 Арсений Живаго. All rights reserved.
//

import UIKit
import SQLite3

class newTrainingViewController: UIViewController {
    
    internal let SQLITE_STATIC = unsafeBitCast(0, to: sqlite3_destructor_type.self)
    internal let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
    
    var newSimpleTrainigs:[String] = []
    var exercisesNames:String = ""
    var exercisesTimes:String = ""
    var typeOfPlace: Int = 0
    
    @IBOutlet weak var newTrainingButtonSelf: UIButton!
    @IBOutlet weak var newTrainingName: UITextField!
    @IBOutlet weak var exerciseName: UITextField!
    @IBOutlet weak var exerciseTime: UITextField!
    @IBOutlet weak var exerciseAddButtonSelf: UIButton!
    @IBOutlet weak var placeSegmentControl: UISegmentedControl!
    
    @IBAction func placeForTraining(_ sender: UISegmentedControl) {
        
        switch placeSegmentControl.selectedSegmentIndex {
        case 0:
            typeOfPlace = 0;
        case 1:
            typeOfPlace = 1;
        default:
            typeOfPlace = 2;
        }
    }
    
    @IBAction func exerciseAddButton(_ sender: UIButton) {
        
        let name = exerciseName.text!
        let time = exerciseTime.text!
        if(name.isEmpty){
            print("name is empty")
            let alertController = UIAlertController(title: "Name is empty", message: "Please enter a name of exercise", preferredStyle: .alert)
            
            self.present(alertController, animated: true, completion:nil)
            
            
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                print("You've pressed OK button");
            }
            alertController.addAction(OKAction)
        } else
        if(time.isEmpty){
            let alertController = UIAlertController(title: "TimeField is empty", message: "Please enter a time of exercise", preferredStyle: .alert)
            
            self.present(alertController, animated: true, completion:nil)
            
            
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                print("You've pressed OK button");
            }
            alertController.addAction(OKAction)
            print("time is empty")
        } else {
        exercisesNames.append(name+",")
        exercisesTimes.append(time+",")
        exerciseTime.text?.removeAll()
        exerciseName.text?.removeAll()
        }
    }
    
    
    @IBAction func newTrainigButton(_ sender: UIButton) {
        let name = newTrainingName.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if(name?.isEmpty)!{
            print("name is empty")
            let alertController = UIAlertController(title: "Name is empty", message: "Please enter a name of training", preferredStyle: .alert)
            
            self.present(alertController, animated: true, completion:nil)
            
            
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                print("You've pressed OK button");
            }
            alertController.addAction(OKAction)
        } else {
            
            
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("trainings1.1.sqlite")
        
        // open database
        
        var db: OpaquePointer?
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        
        if sqlite3_exec(db, "create table if not exists test (id integer primary key autoincrement, name text,exercisesNames text, exercisesTimes text, typeOfPlace integer)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
        
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, "insert into test (name,exercisesNames,exercisesTimes,typeOfPlace) values (?,?,?,?)", -1, &statement, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
        }
        
        if sqlite3_bind_text(statement, 1, name, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding foo: \(errmsg)")
        }
            
            
        if sqlite3_bind_text(statement, 2, exercisesNames, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding foo: \(errmsg)")
        }
            
            
        if sqlite3_bind_text(statement, 3, exercisesTimes, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding foo: \(errmsg)")
        }
            
            if sqlite3_bind_int(statement, 4, Int32(typeOfPlace)) != SQLITE_OK {
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("failure binding foo: \(errmsg)")
            }
            
        
        if sqlite3_step(statement) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure inserting foo: \(errmsg)")
        }
        
        if sqlite3_finalize(statement) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error finalizing prepared statement: \(errmsg)")
        }
        statement = nil
        
        if sqlite3_close(db) != SQLITE_OK {
            print("error closing database")
        }
        
        db = nil
        exercisesNames = ""
        exercisesTimes = ""
        newTrainingName.text?.removeAll()
        
        let alertController = UIAlertController(title: "Saved", message: "Training was saved", preferredStyle: .alert)
        
        self.present(alertController, animated: true, completion:nil)
        
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            print("You've pressed OK button");
        }
        
        alertController.addAction(OKAction)
        }
        
    }
    
    var db: OpaquePointer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newTrainingButtonSelf.layer.cornerRadius = 10
        newTrainingButtonSelf.layer.shadowColor = UIColor.black.cgColor
        newTrainingButtonSelf.layer.shadowOffset = CGSize(width: 2, height: 2)
        newTrainingButtonSelf.layer.shadowOpacity = 0.2
        newTrainingButtonSelf.layer.shadowRadius = 4.0
        newTrainingButtonSelf.layer.masksToBounds = false
        exerciseAddButtonSelf.layer.cornerRadius = 10
        exerciseAddButtonSelf.layer.shadowColor = UIColor.black.cgColor
        exerciseAddButtonSelf.layer.shadowOffset = CGSize(width: 2, height: 2)
        exerciseAddButtonSelf.layer.shadowOpacity = 0.2
        exerciseAddButtonSelf.layer.shadowRadius = 4.0
        exerciseAddButtonSelf.layer.masksToBounds = false
        // Do any additional setup after loading the view.
    }

}

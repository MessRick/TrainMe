//
//  newTrainingViewController.swift
//  TrainMe
//
//  Created by Арсений Живаго on 24.09.2018.
//  Copyright © 2018 Арсений Живаго. All rights reserved.
//

import UIKit
import SQLite3

class newTrainingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    
    
    internal let SQLITE_STATIC = unsafeBitCast(0, to: sqlite3_destructor_type.self)
    internal let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
    
    var newSimpleTrainigs:[String] = []
    var exercisesNames:String = ""
    var exercisesTimes:String = ""
    var oneName: String = ""
    var oneTime: String = ""
    var typeOfPlace: Int = 0
    var exerciseName:[String] = []
    var exerciseTime:[String] = []
    var indexNow = 0
    
    @IBOutlet weak var gradienLine: UIView!
    @IBOutlet weak var ExercisesTableView: UITableView!
    @IBOutlet weak var newTrainingButtonSelf: UIButton!
    @IBOutlet weak var newTrainingName: UITextField!
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
        
//        let name = exerciseName.text!
//        let time = exerciseTime.text!
//        if(name.isEmpty){
//            print("name is empty")
//            let alertController = UIAlertController(title: "Name is empty", message: "Please enter a name of exercise", preferredStyle: .alert)
//            
//            self.present(alertController, animated: true, completion:nil)
//            
//            
//            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
//                print("You've pressed OK button");
//            }
//            alertController.addAction(OKAction)
//        } else
//        if(time.isEmpty){
//            let alertController = UIAlertController(title: "TimeField is empty", message: "Please enter a time of exercise", preferredStyle: .alert)
//            
//            self.present(alertController, animated: true, completion:nil)
//            
//            
//            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
//                print("You've pressed OK button");
//            }
//            alertController.addAction(OKAction)
//            print("time is empty")
//        } else {
//        exercisesNames.append(name+",")
//        exercisesTimes.append(time+",")
//        exerciseTime.text?.removeAll()
//        exerciseName.text?.removeAll()
//        }
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
        } else if (exercisesNames.isEmpty){
            print("name is empty")
            let alertController = UIAlertController(title: "Have no exercises", message: "Please create any exercises", preferredStyle: .alert)
            
            self.present(alertController, animated: true, completion:nil)
            
            
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                print("You've pressed OK button");
            }
            alertController.addAction(OKAction)
        }else {
        
            
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("trainings1.2.sqlite")
        
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
        
//        let alertController = UIAlertController(title: "Saved", message: "Training was saved", preferredStyle: .alert)
//
//        self.present(alertController, animated: true, completion:nil)
//
//
//        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
//            print("You've pressed OK button");
//        }
//
//        alertController.addAction(OKAction)
        }
    
    }
    
    @IBAction func unwindToNewTrainingViewController(segue: UIStoryboardSegue) {
        
        if let sourceViewController = segue.source as? NewExerciseViewController {
            if(sourceViewController.ExerciseNameTextField.text!.isEmpty ){
                
                let alertController = UIAlertController(title: "Name is empty", message: "Please enter a name of exercise", preferredStyle: .alert)
                
                self.present(alertController, animated: true, completion:nil)
                
                
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                    print("You've pressed OK button");
                }
                alertController.addAction(OKAction)
            } else if (sourceViewController.HoursTextField.text!.isEmpty){
                let alertController = UIAlertController(title: "Time fields is empty", message: "Please enter a time for exercise", preferredStyle: .alert)
                
                self.present(alertController, animated: true, completion:nil)
                
                
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                    print("You've pressed OK button");
                }
                alertController.addAction(OKAction)
            } else {
            oneName = sourceViewController.ExerciseNameTextField.text!
            oneTime = String(Int(sourceViewController.HoursTextField.text!)!*1200)
            oneTime = String(Int(oneTime)! + Int(sourceViewController.MinutesTextField.text!)!*60)
            oneTime = String(Int(oneTime)! + Int(sourceViewController.SecondsTextField.text!)!)
        
            print("\n\n Is Done \(oneName)\n  \(oneTime)\n")
            exercisesNames.append(oneName+",")
            exercisesTimes.append(oneTime+",")
            exerciseName = exercisesNames.components(separatedBy: ",")
            exerciseTime = exercisesTimes.components(separatedBy: ",")
            exerciseName.removeLast()
            exerciseTime.removeLast()
            ExercisesTableView.reloadData()
            }
        }
    
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = exerciseName[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexNow = indexPath.item
        performSegue(withIdentifier: "ExerciseSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ExerciseSegue" {
            let recieverVC = segue.destination as! ExerciseViewController
            
            recieverVC.Name = exerciseName[indexNow]
            recieverVC.Time = exerciseTime[indexNow]
            recieverVC.indexOfExercise = indexNow
            //recieverVC.ExerciseTime
        } else {
        }
    }
    
    @IBAction func unwindToTrainingCollectionViewWithDeletedExercise(segue: UIStoryboardSegue) {
        
        var id: Int?
        if let sourceViewController = segue.source as? ExerciseViewController {
            id = sourceViewController.indexOfExercise
        }
        exerciseName.remove(at: id!)
        exerciseTime.remove(at: id!)
        exercisesTimes = exerciseTime.joined(separator: ",")
        exercisesNames = exerciseName.joined(separator: ",")
        ExercisesTableView.reloadData()
        
    }
    
    
    var db: OpaquePointer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.newTrainingName.delegate = self
        exerciseName = exercisesNames.components(separatedBy: ",")
        exerciseName.removeLast()
        newTrainingButtonSelf.layer.cornerRadius = newTrainingButtonSelf.frame.width/2
        newTrainingButtonSelf.layer.shadowColor = UIColor.black.cgColor
        newTrainingButtonSelf.layer.shadowOffset = CGSize(width: 1, height: 2)
        newTrainingButtonSelf.layer.shadowOpacity = 0.3
        newTrainingButtonSelf.layer.shadowRadius = 4.0
        newTrainingButtonSelf.layer.masksToBounds = false
        exerciseAddButtonSelf.layer.cornerRadius = exerciseAddButtonSelf.frame.height/2
        exerciseAddButtonSelf.layer.shadowColor = UIColor.black.cgColor
        exerciseAddButtonSelf.layer.shadowOffset = CGSize(width: 1, height: 2)
        exerciseAddButtonSelf.layer.shadowOpacity = 0.3
        exerciseAddButtonSelf.layer.shadowRadius = 4.0
        exerciseAddButtonSelf.layer.masksToBounds = false
        
        createGradientLayer(for: gradienLine)
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return (true)
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

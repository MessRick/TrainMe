//
//  FirstViewController.swift
//  TrainMe
//
//  Created by Арсений Живаго on 17.09.2018.
//  Copyright © 2018 Арсений Живаго. All rights reserved.
//

import UIKit
import SQLite3

class FirstViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    var trainingIndexNow = 0
    var simpleTrainigs:[String] = []
    var exercisesNamesString:[String] = []
    var exercisesTimesString:[String] = []
   // var refresher: UIRefreshControl!
    var typesOfPlaces:[Int] = []
    var imagesForTypesOfPlaces = ["gym","outcide","home"]
    
    
    @IBAction func newTreaningButton(_ sender: Any) {
        performSegue(withIdentifier: "newTrainingSegue", sender: self)
    }
    @IBOutlet weak var TrainingsCollectionViewController: UICollectionView!
    @IBOutlet weak var TheFirstViewCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        refresher = UIRefreshControl()
//        refresher.addTarget(self, action: #selector(FirstViewController.populate), for: UIControl.Event.valueChanged)
//        TrainingsCollectionViewController.addSubview(refresher)
        
        loadDataFromDatabase()
        
        TrainingsCollectionViewController.dataSource = self
        TrainingsCollectionViewController.delegate = self

        
        let layout = self.TrainingsCollectionViewController.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets.init(top: 20, left: 20, bottom: 20, right: 20)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 20
        
        let width = TrainingsCollectionViewController.frame.width-50
        let height = CGFloat(114)
        let cellSize = CGSize(width: width, height: height)
        layout.itemSize = cellSize
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return simpleTrainigs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let newcell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstCell", for: indexPath) as! TrainingCollectionViewCell
        newcell.NameLabel.text = simpleTrainigs[indexPath.item]
        
        switch typesOfPlaces[indexPath.item] {
        case 1:
            newcell.conditionLabel.text = "gym"
        case 2:
            newcell.conditionLabel.text = "outside"
        default:
            newcell.conditionLabel.text = "home"
        }
        //newcell.conditionLabel.text =
        
//        let gradient = CAGradientLayer()
//        gradient.frame =  CGRect(origin: CGPoint.zero, size: newcell.frame.size)
//        gradient.colors = [UIColor.red.cgColor, UIColor.yellow.cgColor]
//        gradient.cornerRadius = 10
//       // gradient.borderColor = [UIColor.blue.cgColor, UIColor.green.cgColor]
//        newcell.layer.insertSublayer(gradient, at: 0)
        return newcell
    }
    

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        trainingIndexNow = indexPath.item
        performSegue(withIdentifier: "TrainingsSegue", sender: self)
    }
    
    func loadDataFromDatabase(){
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("trainings1.2.sqlite")
        
        // open database
        var db: OpaquePointer?
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        var statement: OpaquePointer?
        if sqlite3_prepare_v2(db, "select id, name, exercisesNames,exercisesTimes,typeOfPlace from test", -1, &statement, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing select: \(errmsg)")
        }
        while sqlite3_step(statement) == SQLITE_ROW {
            let id = sqlite3_column_int64(statement, 0)
            print("id = \(id); ", terminator: "")
            
            if let cString = sqlite3_column_text(statement, 1) {
                let name = String(cString: cString)
                simpleTrainigs.append(name)
            } else {
                print("name not found")
            }
            if let cString2 = sqlite3_column_text(statement, 2) {
                print(cString2)
                let name2 = String(cString: cString2)
                exercisesNamesString.append(name2)
            } else {
                print("name not found")
            }
            if let cString3 = sqlite3_column_text(statement, 3) {
                print(cString3)
                let name3 = String(cString: cString3)
                exercisesTimesString.append(name3)
            } else {
                print("name not found")
            }
            if let int4: Int32 = sqlite3_column_int(statement, 4) {
                print("\n\n")
                print(int4)
                print("\n\n")
                typesOfPlaces.append(Int(int4))
            } else {
                print("name not found")
            }
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
    }
    
    @objc func populate()
    {
        simpleTrainigs = []
        exercisesTimesString = []
        exercisesNamesString = []
        typesOfPlaces = []
        loadDataFromDatabase()
        TrainingsCollectionViewController.reloadData()
        refresher.endRefreshing()
    }
    
    @IBAction func unwindToTrainingCollectionViewViewController(segue: UIStoryboardSegue) {
        simpleTrainigs = []
        exercisesTimesString = []
        exercisesNamesString = []
        typesOfPlaces = []
        loadDataFromDatabase()
        TrainingsCollectionViewController.reloadData()
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TrainingsSegue" {
            let recieverVC = segue.destination as! TrainigsViewController
            recieverVC.labelName = simpleTrainigs[trainingIndexNow]
            recieverVC.exerciseNameDefaulte = exercisesNamesString[trainingIndexNow]
            recieverVC.exerciseTimeDefaulte = exercisesTimesString[trainingIndexNow]
        } else {
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


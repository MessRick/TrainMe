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
    var refresher: UIRefreshControl!
    var typesOfPlaces:[Int] = []
    var imagesForTypesOfPlaces = ["gym","outcide","home"]
    
    
    @IBAction func newTreaningButton(_ sender: Any) {
        performSegue(withIdentifier: "newTrainingSegue", sender: self)
    }
    @IBOutlet weak var TrainingsCollectionViewController: UICollectionView!
    @IBOutlet weak var TheFirstViewCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(FirstViewController.populate), for: UIControl.Event.valueChanged)
        TrainingsCollectionViewController.addSubview(refresher)
        
        loadDataFromDatabase()
        
        TrainingsCollectionViewController.dataSource = self
        TrainingsCollectionViewController.delegate = self
        
        let layout = self.TrainingsCollectionViewController.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets.init(top: 20, left: 70, bottom: 20, right: 70)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 20
        
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
        newcell.layer.cornerRadius = 10
        newcell.layer.shadowColor = UIColor.black.cgColor
        newcell.layer.shadowOffset = CGSize(width: 2, height: 2)
        newcell.layer.shadowOpacity = 0.2
        newcell.layer.shadowRadius = 4.0
        newcell.layer.masksToBounds = false
        newcell.trainingImage.image = UIImage(named: imagesForTypesOfPlaces[typesOfPlaces[indexPath.item]])
        newcell.trainingImage.contentMode = .scaleToFill
        newcell.trainingImage.layer.cornerRadius = 10
        newcell.trainingImage.layer.masksToBounds = true
        return newcell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        trainingIndexNow = indexPath.item
        performSegue(withIdentifier: "TrainingsSegue", sender: self)
    }
    
    func loadDataFromDatabase(){
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("trainings1.1.sqlite")
        
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
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TrainingsSegue" {
            let recieverVC = segue.destination as! TrainigsViewController
            recieverVC.labelName = simpleTrainigs[trainingIndexNow]
            recieverVC.exerciseNameDefaulte = exercisesNamesString[trainingIndexNow]
            recieverVC.exerciseTimeDefaulte = exercisesTimesString[trainingIndexNow]
        } else {
        }
    }


}


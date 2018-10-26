//
//  SecondViewController.swift
//  TrainMe
//
//  Created by Арсений Живаго on 17.09.2018.
//  Copyright © 2018 Арсений Живаго. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    @IBOutlet weak var MyCollectionView: UICollectionView!
    
    var indexNow = 0
    
    let namesOfDiches = ["Мексиканские тако Сальса-Верде с начинкой из чечевицы, манго и граната.","Сладкий сырный картофель, фаршированный черной фасолью с яйцами.","Запеченные оладьи из кабачков.","Жареный фенхель, спаржа и красный лук с пармезаном и яйцами вкрутую.","Питательный гороховый суп.","Сладкие лепешки из картофеля и чечевицы с лимонным соусом.","Вкусные «стейки» из цветной капусты с чечевицей."]
    
    let imagesName = ["tako_salsa-verde_2","syrnyy_kartofel_3","oladi_iz_kabachkov_2","zharenyy_fenhel_2","gorohovyy_sup_2","lepeshki_iz_kartofelya_i_chechevicy_2","steyki_iz_cvetnoy_kapusty_2"]
    
    let filePaths = ["tako_salsa-verde","syrnyy_kartofel","oladi_iz_kabachkov","zharenyy_fenhel","gorohovyy_sup","lepeshki_iz_kartofelya_i_chechevicy","steyki_iz_cvetnoy_kapusty"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MyCollectionView.dataSource = self
        MyCollectionView.delegate = self
        
        let layout = self.MyCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets.init(top: 20, left: 70, bottom: 20, right: 70)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 20
        
        let width = MyCollectionView.frame.width-68
        let height = CGFloat(114)
        
        let cellSize = CGSize(width: width, height: height)
        layout.itemSize = cellSize
        
    }

    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return namesOfDiches.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell

        cell.caloriesLabel.text = "20 ccal"
        cell.CellLabel.text = namesOfDiches[indexPath.item]
      
        cell.MyImage.image = UIImage(named: imagesName[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        indexNow = indexPath.item
        print(indexNow)
        performSegue(withIdentifier: "FoodSegue", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let recieverVC = segue.destination as! FoodsViewComtroller
        recieverVC.imageForView = UIImage(named: imagesName[indexNow])
        recieverVC.foodName = namesOfDiches[indexNow]
        let niceFile = Bundle.main.path(forResource:filePaths[indexNow] , ofType: "txt")
        do{
            recieverVC.labelText = try String(contentsOfFile: niceFile!, encoding: String.Encoding.utf8)
        } catch {
            print("failed")
        }
        
    }
}


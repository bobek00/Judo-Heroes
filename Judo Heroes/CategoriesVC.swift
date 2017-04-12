//
//  CategoriesVC.swift
//  Judo Heroes
//
//  Created by Boris Rudas on 05/04/2017.
//  Copyright © 2017 Boris Rudas. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CategoriesVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet var competitionNameLbl: UILabel!
    @IBOutlet var menCollectionView: UICollectionView!
    @IBOutlet var womenCollectionView: UICollectionView!

    
    var ref: FIRDatabaseReference!
    
    var competitionYear = String()
    var competitionID = String()
    var competitionName = String()
    
    var under60 = String()
    var under66 = String()
    var under73 = String()
    var under81 = String()
    var under90 = String()
    var under100 = String()
    var over100 = String()
    
    var mensCategories = [String]()
    
    var under48 = String()
    var under52 = String()
    var under57 = String()
    var under63 = String()
    var under70 = String()
    var under78 = String()
    var over78 = String()
    
    var womenCategories = [String]()
    var selectedCategory = String()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ref = FIRDatabase.database().reference()
        competitionNameLbl.text = competitionName
//        print(competitionID)
//        print(competitionYear)
        
        importCompetitionData()

    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.view.addSubview(menCollectionView)
        self.view.addSubview(womenCollectionView)

    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.menCollectionView {
            return mensCategories.count
        } else {
            return womenCategories.count
        }
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.menCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menCell", for: indexPath as IndexPath) as! MenCategoriesCVCell
            
            if mensCategories[indexPath.row] == "1" {
                cell.menCategoryLbl.text = "-60 kg"
            } else if mensCategories[indexPath.row] == "2" {
                cell.menCategoryLbl.text = "-66 kg"
            } else if mensCategories[indexPath.row] == "3" {
                cell.menCategoryLbl.text = "-73 kg"
            } else if mensCategories[indexPath.row] == "4" {
                cell.menCategoryLbl.text = "-81 kg"
            } else if mensCategories[indexPath.row] == "5" {
                cell.menCategoryLbl.text = "-90 kg"
            } else if mensCategories[indexPath.row] == "6" {
                cell.menCategoryLbl.text = "-100 kg"
            } else if mensCategories[indexPath.row] == "7" {
                cell.menCategoryLbl.text = "+100 kg"
            } else {
                cell.menCategoryLbl.text = ""
            }
            return cell
       
        } else if collectionView == self.womenCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "womenCell", for: indexPath as IndexPath) as! WomenCategoriesCVCell
            
            if womenCategories[indexPath.row] == "8" {
                cell.womenCategoryLbl.text = "-48 kg"
            } else if womenCategories[indexPath.row] == "9" {
                cell.womenCategoryLbl.text = "-52 kg"
            } else if womenCategories[indexPath.row] == "10" {
                cell.womenCategoryLbl.text = "-57 kg"
            } else if womenCategories[indexPath.row] == "11" {
                cell.womenCategoryLbl.text = "-63 kg"
            } else if womenCategories[indexPath.row] == "12" {
                cell.womenCategoryLbl.text = "-70 kg"
            } else if womenCategories[indexPath.row] == "13" {
                cell.womenCategoryLbl.text = "-78 kg"
            } else if womenCategories[indexPath.row] == "14" {
                cell.womenCategoryLbl.text = "+78 kg"
            } else {
                cell.womenCategoryLbl.text = ""
            }
            
            return cell
            
        } else {
            return UICollectionViewCell()
        }
    }
    public func importCompetitionData() {
        let competitionRegistrationsRef = ref.child("competitions/\(competitionYear)/\(competitionID)/registrations")
        
        competitionRegistrationsRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
        let menData = snapshot.childSnapshot(forPath: "categories").childSnapshot(forPath: "1")

            if menData != nil {
                let under60 = menData.childSnapshot(forPath: "1").key
                let under66 = menData.childSnapshot(forPath: "2").key
                let under73 = menData.childSnapshot(forPath: "3").key
                let under81 = menData.childSnapshot(forPath: "4").key
                let under90 = menData.childSnapshot(forPath: "5").key
                let under100 = menData.childSnapshot(forPath: "6").key
                let over100 = menData.childSnapshot(forPath: "7").key
                
                
                self.under60 = under60
                self.under66 = under66
                self.under73 = under73
                self.under81 = under81
                self.under90 = under90
                self.under100 = under100
                self.over100 = over100
                self.mensCategories.append(self.under60)
                self.mensCategories.append(self.under66)
                self.mensCategories.append(self.under73)
                self.mensCategories.append(self.under81)
                self.mensCategories.append(self.under90)
                self.mensCategories.append(self.under100)
                self.mensCategories.append(self.over100)
                
            }
            
            let womenData = snapshot.childSnapshot(forPath: "categories").childSnapshot(forPath: "2")

            if womenData != nil {
                let under48 = menData.childSnapshot(forPath: "8").key
                let under52 = menData.childSnapshot(forPath: "9").key
                let under57 = menData.childSnapshot(forPath: "10").key
                let under63 = menData.childSnapshot(forPath: "11").key
                let under70 = menData.childSnapshot(forPath: "12").key
                let under78 = menData.childSnapshot(forPath: "13").key
                let over78 = menData.childSnapshot(forPath: "14").key
                
                self.under48 = under48
                self.under52 = under52
                self.under57 = under57
                self.under63 = under63
                self.under70 = under70
                self.under78 = under78
                self.over78 = over78
                self.womenCategories.append(self.under48)
                self.womenCategories.append(self.under52)
                self.womenCategories.append(self.under57)
                self.womenCategories.append(self.under63)
                self.womenCategories.append(self.under70)
                self.womenCategories.append(self.under78)
                self.womenCategories.append(self.over78)
                
            }
        })
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.menCollectionView {
            print(mensCategories[indexPath.row])
            self.selectedCategory = mensCategories[indexPath.row]
            
            print(selectedCategory)
            
        } else if collectionView == self.womenCollectionView {
            print(womenCategories[indexPath.row])
            self.selectedCategory = womenCategories[indexPath.row]
            print(selectedCategory)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "menCompetitorsSegue" {
            if let competitorsVC = segue.destination as? CompetitorsVC {

                competitorsVC.competitionID = competitionID
                competitorsVC.competitionName = competitionName
                competitorsVC.competitionYear = competitionYear
                
                if let menIndexPath = menCollectionView.indexPath(for: sender as! MenCategoriesCVCell){
                    competitorsVC.category = mensCategories[menIndexPath.row]
                }
            }
        } else if segue.identifier == "womenCompetitorsSegue" {
            if let competitorsVC = segue.destination as? CompetitorsVC {
                
                competitorsVC.competitionID = competitionID
                competitorsVC.competitionName = competitionName
                competitorsVC.competitionYear = competitionYear
                
                if let womenIndexPath = womenCollectionView.indexPath(for: sender as! WomenCategoriesCVCell){
                    competitorsVC.category = womenCategories[womenIndexPath.row]
                    
                }
            }
        }
    }


}

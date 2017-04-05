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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        competitionNameLbl.text = competitionName
        print(competitionID)
        print(competitionYear)
        
        importCompetitionData()

    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.view.addSubview(menCollectionView)
        self.view.addSubview(womenCollectionView)
        

    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.menCollectionView {
            return 7
        } else {
            return 7
        }
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.menCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menCell", for: indexPath as IndexPath) as! MenCategoriesCVCell
            
            cell.menCategoryLbl.text = "Men"
            
            return cell
       
        } else if collectionView == self.womenCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "womenCell", for: indexPath as IndexPath) as! WomenCategoriesCVCell
            
            cell.womenCategoryLbl.text = "Women"
            
            return cell
            
        } else {
            return UICollectionViewCell()
        }
    }
    public func importCompetitionData() {
        let competitionRegistrationsRef = ref.child("competitions/\(competitionYear)/\(competitionID)/registrations")
        
        competitionRegistrationsRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            print(snapshot.childSnapshot(forPath: "categories"))
            
            
            
        })
        
    }


}

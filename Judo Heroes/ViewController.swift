//
//  ViewController.swift
//  Judo Heroes
//
//  Created by Boris Rudas on 31/03/2017.
//  Copyright © 2017 Boris Rudas. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ViewController: UIViewController {
    
    var ref: FIRDatabaseReference!
    var competitionYears: [Any] = []
    var competitionYear = Int()
    var competitionIDs : [Any] = []
    var competitionID = Int()
    var competitionNames : [String] = []
    var finishedCompetitions : [String] = []
    var futureCompetitions : [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkForUser()
        importCompetitionData()
        
    }

    func importCompetitionData() {
        let competitionsRef = ref.child("competitions")
        
        competitionsRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            let rootValue = snapshot.value as? NSDictionary
            let years = rootValue?.allKeys
            
            self.competitionYears = years!
            for year in self.competitionYears {
                competitionsRef.child(year as! String).observe(.value, with: { (snapshot) in

                    let dataForYear = snapshot.value as! NSDictionary
                    self.competitionIDs = dataForYear.allKeys

                        for compID in self.competitionIDs {

                            competitionsRef.child(year as! String).child(compID as! String).observe(.value, with: { (snapshot) in
//                                print(snapshot.value as! NSDictionary)
                                let dataForCompetition = snapshot.value as! NSDictionary
//                                print(dataForCompetition.value(forKey: "has_results") as! Int)
                                
                                if dataForCompetition.value(forKey: "has_results") as! Int != 0 {
//                                    print("rezultati so")
                                    self.finishedCompetitions.append(compID as! String)
                                    
                                } else {
//                                    print("rezultatov ni")
                                    self.futureCompetitions.append(compID as! String)
                                    
                                }
                                self.competitionNames = [dataForCompetition.value(forKey: "name") as! String]
//                                print(self.competitionNames)
                                print("Past competitions: \(self.finishedCompetitions.count)")
                                print("Future competitions: \(self.futureCompetitions.count)")
                            })
                            
                    }
                })
            }
         })
    }
    func checkForUser() {
        ref = FIRDatabase.database().reference()
        FIRAuth.auth()?.addStateDidChangeListener() {(auth, user) in
            if auth.currentUser == nil {
                print("No user")
                self.performSegue(withIdentifier: "logIn", sender: ViewController.self)
            }
            else{
                print("We have a user: \(String(describing: auth.currentUser))")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


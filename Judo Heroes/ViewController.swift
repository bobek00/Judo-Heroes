//
//  ViewController.swift
//  Judo Heroes
//
//  Created by Boris Rudas on 31/03/2017.
//  Copyright © 2017 Boris Rudas. All rights reserved.
//

import UIKit
import Foundation   
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var competitionsTableView: UITableView!
    
    var ref: FIRDatabaseReference!
    var competitionYears: [Any] = []
    var competitionYear = Int()
    var competitionIDs : [Any] = []
    var competitionID = Int()
    var competitionNames : [String] = []
    var finishedCompetitions : [String] = []
    var futureCompetitions : [String] = []
    var competition = [Competition]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

//        competitionsTableView.reloadData()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "compInfoSegue" {
            if let compInfoVC = segue.destination as? CompetitionInfoVC {
                if let path = self.competitionsTableView.indexPathForSelectedRow {
                    compInfoVC.competitionID = self.competitionIDs[path.row] as! String
                    compInfoVC.competitionName = self.competitionNames[path.row]
                }
            }
        }
    }
        override func viewWillAppear(_ animated: Bool) {
        checkForUser()
        importCompetitionData()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.backgroundColor = UIColor.black
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.text = self.competitionNames[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "compInfoSegue", sender: ViewController.self)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.competitionNames.count
    }

    public func importCompetitionData() {
        let competitionsRef = ref.child("competitions")
        
        competitionsRef.queryOrderedByValue().observeSingleEvent(of: .value, with: { (snapshot) in
            
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
                                
                                let has_results = dataForCompetition.value(forKey: "has_results") as! Int
                                let name = dataForCompetition.value(forKey: "name") as! String
                                let date_from = dataForCompetition.value(forKey: "date_from") as! String
                                let date_to = dataForCompetition.value(forKey: "date_to") as! String
                                let country = dataForCompetition.value(forKey: "country") as! String
                                let city = dataForCompetition.value(forKey: "city") as! String
                                let country_short = dataForCompetition.value(forKey: "country_short") as! String
                                let rank_name = dataForCompetition.value(forKey: "rank_name") as! String

                                self.competitionNames.append(name)
                                
                                self.competitionsTableView.reloadData()
                                
                                let competition = Competition.init(has_results: has_results, name: name, date_from: date_from, date_to: date_to, country: country, city: city, country_short: country_short, rank_name: rank_name)
                                
//                                print(competition.date_from)
//                                let dateString = competition.date_from
//                                let dateFormatter = DateFormatter()
//                                dateFormatter.dateFormat = "dd/MM/yyyy"
//                                let competitionStartDate = dateFormatter.date(from: dateString)
//                                print(competitionStartDate!)
//                                if competitionStartDate! < NSDate() as Date {
//                                    print(competition.name,"Past event")
//                                } else if competitionStartDate! > NSDate() as Date {
//                                    print(competition.name,"Future event")
//                                } else if competitionStartDate! == NSDate() as Date {
//                                    print(competition.name,"Event starts today")                                                                                     
//                                } else {
//                                    print("wtf")
//                                }
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


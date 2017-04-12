//
//  CompetitorsVC.swift
//  Judo Heroes
//
//  Created by Boris Rudas on 11/04/2017.
//  Copyright © 2017 Boris Rudas. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SDWebImage

class CompetitorsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var competitorsTV: UITableView!
    @IBOutlet var categoryLbl: UILabel!
    @IBOutlet var competitionLbl: UILabel!
    
    var ref: FIRDatabaseReference!
    
    var competitionName = String()
    var competitionYear = String()
    var competitionID = String()
    var gender = String()
    var competitorsNames = [String]()
    var competitorsCountries = [String]()
    var competitorsIDs = [String]()
    var competitorsCountriesShort = [String]()
    
    var category = String()
    var competitorID = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        FIRDatabase.database().persistenceEnabled = true
        
        changeLabelAndGender()
        ref = FIRDatabase.database().reference()
        importCompetitors()
        
        self.competitionLbl.text = competitionName

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "competitorsCell", for: indexPath) as! CompetitorTVC
        
        cell.competitorNameLbl.text = competitorsNames[indexPath.row]
        cell.competitorCountryLbl.text = competitorsCountries[indexPath.row]
        cell.competitorImg.sd_setImage(with: URL(string: "https://78884ca60822a34fb0e6-082b8fd5551e97bc65e327988b444396.ssl.cf3.rackcdn.com/profiles/350/\(competitorsIDs[indexPath.row]).jpg"))
        cell.competitorImg.layer.cornerRadius = cell.competitorImg.frame.size.width / 2
        cell.competitorCountryImg.sd_setImage(with: URL(string:"http://www.judobase.org/assets/img/flags/320x240/\(competitorsCountriesShort[indexPath.row]).png"))
        
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return competitorsNames.count
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    func importCompetitors() {
    
        let competitorsRef = ref.child("competitions/\(competitionYear)/\(competitionID)/registrations/categories/\(gender)/\(category)/persons/")
        competitorsRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            let rootValue = snapshot.value as? NSDictionary
            let competitorsIDs = rootValue?.allKeys
            self.competitorsIDs = competitorsIDs as! [String]
            
            for competitorID in competitorsIDs! {
                let competitorInfo = rootValue?.value(forKey: "\(competitorID)") as! NSDictionary
                
                let family_name = competitorInfo.value(forKey: "family_name") as! String
                let given_name = competitorInfo.value(forKey: "given_name") as! String
                let country = competitorInfo.value(forKey: "country") as! String
                let countryShort = competitorInfo.value(forKey: "country_short") as! String
                
                let competitorFullName = "\(family_name) \(given_name)"
                self.competitorsNames.append(competitorFullName)
                self.competitorsCountries.append(country)
                self.competitorsCountriesShort.append(countryShort.lowercased())
            }
        })
    }
    func changeLabelAndGender() {
        if category == "1" {
            gender = "1"
            self.categoryLbl.text = "- 60 kg"
        } else if category == "2" {
            gender = "1"
            self.categoryLbl.text = "- 66 kg"
        }else if category == "3" {
            gender = "1"
            self.categoryLbl.text = "- 73 kg"
        }else if category == "4" {
            gender = "1"
            self.categoryLbl.text = "- 81 kg"
        }else if category == "5" {
            gender = "1"
            self.categoryLbl.text = "- 90 kg"
        }else if category == "6" {
            gender = "1"
            self.categoryLbl.text = "- 100 kg"
        }else if category == "7" {
            gender = "1"
            self.categoryLbl.text = "+ 100 kg"
        }else if category == "8" {
            gender = "2"
            self.categoryLbl.text = "- 48 kg"
        }else if category == "9" {
            gender = "2"
            self.categoryLbl.text = "- 52 kg"
        }else if category == "10" {
            gender = "2"
            self.categoryLbl.text = "- 57 kg"
        }else if category == "11" {
            gender = "2"
            self.categoryLbl.text = "- 63 kg"
        }else if category == "12" {
            gender = "2"
            self.categoryLbl.text = "- 70 kg"
        }else if category == "13" {
            gender = "2"
            self.categoryLbl.text = "- 78 kg"
        }else if category == "14" {
            gender = "2"
            self.categoryLbl.text = "+ 78 kg"
        }
    }

}

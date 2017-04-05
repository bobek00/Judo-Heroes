//
//  CompetitionInfoVC.swift
//  Judo Heroes
//
//  Created by Boris Rudas on 04/04/2017.
//  Copyright © 2017 Boris Rudas. All rights reserved.
//

import UIKit
import SDWebImage

class CompetitionInfoVC: UIViewController {

    @IBOutlet var infoview: UIView!
    @IBOutlet var cityLbl: UILabel!
    @IBOutlet var countryLbl: UILabel!
    @IBOutlet var dateLbl: UILabel!
    @IBOutlet var CompetitionNameLabel: UILabel!
    @IBOutlet var cityImg: UIImageView!
    
    var competitionName = String()
    var competitionID = String()
    var competitionYear = String()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        

        CompetitionNameLabel.text = competitionName
        parseDataFromUrl()
        print(competitionYear)

    }
    override func viewWillAppear(_ animated: Bool) {
        infoview.layer.cornerRadius = 6
        
        
    }
    func parseDataFromUrl() {
        let urlString = "http://data.judobase.org/api/get_json?access_token=&params%5Baction%5D=general.get_one&params%5B__ust%5D=&params%5Bmodule%5D=competition&params%5Bid%5D=\(competitionID)"
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            if error != nil {
                print(error!)
            } else {
                do {
                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                    
                    let city = parsedData["city"] as! String
                    let country = parsedData["country"] as! String
                    let bgpic = parsedData["bgpic"] as! String
                    let date_from = parsedData["date_from"] as! String
                    let date_to = parsedData["date_to"] as! String
                    
//                    let ages = parsedData["ages"] as! String
//                    let country_short = parsedData["country_short"] as! String
//                    let rank_group = parsedData["rank_group"] as! String
//                    let rank_name = parsedData["rank_name"] as! String
                    var year = parsedData["year"] as! String
//                    let title = parsedData["title"] as! String
                    
                    self.cityLbl.text = city
                    self.countryLbl.text = country
                    self.dateLbl.text = "The competition will be held from \(date_from) until \(date_to)"
                    self.cityImg.sd_setImage(with: URL(string: bgpic))
                    self.competitionYear = year
                    
                } catch let error as NSError {
                    print(error)
                }
            }
            }.resume()
    }
    
    @IBAction func dissmisButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "categoriesSegue" {
            if let compCatVC = segue.destination as? CategoriesVC {
                    compCatVC.competitionID = competitionID
                    compCatVC.competitionName = competitionName
                    compCatVC.competitionYear = self.competitionYear
                
            }
        }
    }

}

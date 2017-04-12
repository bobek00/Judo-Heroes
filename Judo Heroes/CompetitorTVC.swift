//
//  CompetitorTVC.swift
//  Judo Heroes
//
//  Created by Boris Rudas on 11/04/2017.
//  Copyright © 2017 Boris Rudas. All rights reserved.
//

import UIKit

class CompetitorTVC: UITableViewCell {

    @IBOutlet var competitorCountryLbl: UILabel!
    @IBOutlet var competitorImg: UIImageView!
    @IBOutlet var competitorNameLbl: UILabel!
    @IBOutlet var competitorCountryImg: UIImageView!
    
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  TableViewCell.swift
//  Rate
//
//  Created by Rotach Roman on 29.06.2020.
//  Copyright © 2020 Roman. All rights reserved.
//

import UIKit

class RateTableViewCell: UITableViewCell {
    
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var costsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(keyRate: String, valueRate: Double) {
        self.currencyLabel.text = keyRate
        self.costsLabel.text = String(valueRate)
    }
    
    func set(keyRate: String){
        self.currencyLabel.text = keyRate
    }
}

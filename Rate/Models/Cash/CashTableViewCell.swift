//
//  CashTableViewCell.swift
//  Rate
//
//  Created by Rotach Roman on 05.07.2020.
//  Copyright © 2020 Roman. All rights reserved.
//

import UIKit

class CashTableViewCell: UITableViewCell {

    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var valueTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func set(currency: String, value: Double?) {
        self.currencyLabel.text = currency
        guard let val = value else { return }
        self.valueTextField.text = String(val)
    }

}

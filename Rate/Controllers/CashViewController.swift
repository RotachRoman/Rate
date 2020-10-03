//
//  CashViewController.swift
//  Rate
//
//  Created by Rotach Roman on 05.07.2020.
//  Copyright © 2020 Roman. All rights reserved.
//

import UIKit

class CashViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var cashTable: UITableView!
    
    @IBOutlet weak var currencyButton: UIButton!
    @IBOutlet weak var currencyView: UIView!
    @IBOutlet weak var currencyTable: UITableView!
    
    private var lurkTable = WorkWithTable()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lurkTable.trueHidden(view: currencyView, table: currencyTable)
        lurkTable.view(view: currencyView, table: currencyTable, button: currencyButton)
        
        currencyTable.delegate = self
        currencyTable.dataSource = self
        
        cashTable.delegate = self
        cashTable.dataSource = self
    }
    
    @IBAction func currencyTapped(_ sender: UIButton) {
        lurkTable.hiddenTable(view: currencyView, table: currencyTable, button: currencyButton)
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return currencyDictionary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == currencyTable {
            let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell", for: indexPath)
            cell.textLabel?.text = currencyDictionary[indexPath.row]
            
            return cell
        } else {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "cashCell", for: indexPath) as! CashTableViewCell
            let currency = currencyDictionary[indexPath.row]
            cell.set(currency: currency, value: nil)
            
            return cell
        }
    }
}

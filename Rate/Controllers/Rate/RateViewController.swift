//
//  ViewController.swift
//  Rate
//
//  Created by Rotach Roman on 28.06.2020.
//  Copyright © 2020 Roman. All rights reserved.
//

import UIKit

private var rateForTable: [String: Double] = [:]

var keyString = [String]()
var valueDouble = [Double]()


//MARK: ViewController
class RateViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var canGo = true
    
    private var networkRateManager = NetworkRateManager()
    private var addTable = WorkWithTable()
    
    @IBOutlet weak var mainCurrencyButton: UIButton!
    @IBOutlet weak var choiceCurrency: UILabel!
    @IBOutlet weak var rateTableView: UITableView!
    
    @IBOutlet weak var additionallyView: UIView!
    @IBOutlet weak var additionallyTable: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)

    
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTable.hiddenTable(view: additionallyView, table: additionallyTable, button: mainCurrencyButton)
        
        networkRateManager.onCompletion = {[weak self] currentRate in
            guard let self = self else { return }
            self.updateInterface(rate: currentRate)
        }
        
        let defaultCurrency = "EUR"
        self.networkRateManager.fetchCurrentRate(currency: defaultCurrency)
        
        self.additionallyTable.delegate = self
        self.additionallyTable.dataSource = self
    }
    
    //MARK: updateInterface
    func updateInterface(rate: CurrentRate)  {
        
        DispatchQueue.main.async {
            
            self.mainCurrencyButton.setTitle("\(rate.base)", for: .normal)
            
            self.choiceCurrency.text = rate.date
            rateForTable = rate.rates
            
            self.rateTableView.delegate = self
            self.rateTableView.dataSource = self
            self.rateTableView.reloadData()
        }
    }
    
    //MARK:- tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == rateTableView {
            return rateForTable.count
        } else {
            return currencyDictionary.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        if tableView == rateTableView {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RateTableViewCell
    
            var count = 0
            if canGo {
//                for (key,value) in (Array(rateForTable).sorted {$0.1 < $1.1}) {
//                    print(key)
//                    keyString.append(key)
//                    print(value)
//                    valueDouble.append(value)
//                    count += 1
//                }
                let dictSortByValue = rateForTable.sorted(by: {$0.key < $1.key} )

                for item in dictSortByValue {
                    print(item.key)
                    keyString.append(item.key)
                    print(item.value)
                    valueDouble.append(item.value)
                    count += 1
                }
                
                canGo = false
            }
//            let keyRate = Array(rateForTable.keys)[indexPath.row]
//            let valueRate = Array(rateForTable.values)[indexPath.row]

            cell.set(keyRate: keyString[indexPath.row], valueRate: valueDouble[indexPath.row])
//
//            print(Array(rateForTable).sorted {$0.1 < $1.1})
//            if canGo {
//            for (key,val) in (Array(rateForTable).sorted {$0.1 < $1.1}) {
//
////                print(val)
//                cell.set(keyRate: key, valueRate: val)
//                }
//                canGo = false
//            }
            
            if indexPath.row == rateForTable.keys.count{
                canGo = true
            }
//            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "addCell", for: indexPath)
            cell.textLabel?.text = currencyDictionary[indexPath.row]
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == additionallyTable{
            
            self.networkRateManager.fetchCurrentRate(currency: currencyDictionary[indexPath.row])
            
            networkRateManager.onCompletion = {[weak self] currentRate in
                guard let self = self else { return }
                self.updateInterface(rate: currentRate)
            }
            
            addTable.hiddenTable(view: additionallyView, table: additionallyTable, button: mainCurrencyButton)
        }
    }
    
    //MARK:- @IBAction
    
    @IBAction func currentlyChangeButton(_ sender: UIButton) {
        
        addTable.hiddenTable(view: additionallyView, table: additionallyTable, button: mainCurrencyButton)
    }
    
}

//extension ViewController: UISearchResultsUpdating {
//    func updateSearchResults(for searchController: UISearchController) {
//
//    }
//
//    private func filterContentForSearchText(_ searchText: String){
//
//        additionallyFilterRate =
//    }
//}
//
//extension RateViewController: UISearchResultsUpdating {
//    func updateSearchResults(for searchController: UISearchController) {
//        <#code#>
//    }
//
//
//}

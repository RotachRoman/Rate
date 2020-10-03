//
//  CalculatorViewController.swift
//  Rate
//
//  Created by Rotach Roman on 01.07.2020.
//  Copyright © 2020 Roman. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var fromButton: UIButton!
    @IBOutlet weak var fromView: UIView!
    @IBOutlet weak var fromTable: UITableView!
    @IBOutlet weak var fromTextField: UITextField!
    
    @IBOutlet weak var toButton: UIButton!
    @IBOutlet weak var toView: UIView!
    @IBOutlet weak var toTable: UITableView!
    @IBOutlet weak var toTextField: UITextField!
    
    private var value: Int?
    private var networkRateManager = NetworkRateManager()
    private var networkCalculatorManager = NetworkCalculatorManager()
    private var table = WorkWithTable()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.trueHidden(view: fromView, table: fromTable)
        table.trueHidden(view: toView, table: toTable)
        
        table.view(view: fromView, table: fromTable, button: fromButton)
        table.view(view: toView, table: toTable, button: toButton)
        
        selfDelegateAndDataSource(table: fromTable)
        selfDelegateAndDataSource(table: toTable)
        
        networkCalculatorManager.onCompletion = {[weak self] currentCalculator in
//            guard let self = self else { return }
            guard self != nil else { return }
//            self.updateInterface()
        }
    }
    
    func updateInterface(rate: CurrentCalculator){
        guard self.fromButton.titleLabel?.text == rate.base else { return } // проверка на точность запроса
        
        fromTextField.text = "1"
        toTextField.text = "\(rate.rub)"
        value = rate.rub
    }
    
    func selfDelegateAndDataSource(table: UITableView) {
        table.delegate = self
        table.dataSource = self
    }
    
    //MARK:- IBActions
    
    @IBAction func fromTapped(_ sender: UIButton) {
        table.trueHidden(view: toView, table: toTable)
        fromButton.setImage(UIImage(systemName: "chevron.down.square"), for: .normal)
        
        table.hiddenTable(view: fromView, table: fromTable, button: fromButton)
    }
    
    @IBAction func toTapped(_ sender: UIButton) {
        
        table.hiddenTable(view: toView, table: toTable, button: toButton)
    }
    
    @IBAction func estimationTapped(_ sender: UIButton) {
           
        value = 70
           guard let from = fromTextField.text, from != "" else { return } // else вывести ошибку
           guard value != nil else { return } // else вывести ошибку
           
        toTextField.text = "\(value! * Int(from)!)"
       }
    
    //MARK:- tableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return currencyDictionary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "addCell", for: indexPath)
        cell.textLabel?.text = currencyDictionary[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.networkRateManager.fetchCurrentRate(currency: currencyDictionary[indexPath.row])
        
        if tableView == fromTable {
            
            fromButton.setTitle("\(currencyDictionary[indexPath.row])", for: .normal)
            table.hiddenTable(view: fromView, table: fromTable, button: fromButton)
        } else {
            
            toButton.setTitle("\(currencyDictionary[indexPath.row])", for: .normal)
            table.hiddenTable(view: toView, table: toTable, button: toButton)
        }
    }
}

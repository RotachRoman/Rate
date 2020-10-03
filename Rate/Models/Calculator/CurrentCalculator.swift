//
//  Calculator.swift
//  Rate
//
//  Created by Rotach Roman on 03.07.2020.
//  Copyright © 2020 Roman. All rights reserved.
//

import Foundation


struct CurrentCalculator {
    let rub: Int
    let base, date: String
    
    init?(calculatorData: CalculatorData){
        
        rub = calculatorData.rates.rub
        base = calculatorData.base
        date = calculatorData.date
    }
}

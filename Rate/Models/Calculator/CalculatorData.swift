//
//  CalculatorData.swift
//  Rate
//
//  Created by Rotach Roman on 03.07.2020.
//  Copyright © 2020 Roman. All rights reserved.
//

import Foundation

struct CalculatorData: Codable {
    let rates: Rates
    let base, date: String
}

struct Rates: Codable {
    let rub: Int
    
    enum CodingKeys: String, CodingKey {
        case rub = "RUB"
    }
}



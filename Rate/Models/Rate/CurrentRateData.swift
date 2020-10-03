//
//  CurrentRateData.swift
//  Rate
//
//  Created by Rotach Roman on 28.06.2020.
//  Copyright © 2020 Roman. All rights reserved.
//

import Foundation


struct CurrentRateData: Codable {
    
    let rates: [String: Double]
    let base, date: String
    
    
}

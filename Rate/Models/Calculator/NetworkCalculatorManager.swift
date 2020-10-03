//
//  NetworkCalculatorManager.swift
//  Rate
//
//  Created by Rotach Roman on 03.07.2020.
//  Copyright © 2020 Roman. All rights reserved.
//

import Foundation

class NetworkCalculatorManager {
    
    var onCompletion: ((CurrentCalculator) -> Void )?
    
    func fetchCurrentRate(from: String, to: String){
        
        let urlString = "https://api.exchangeratesapi.io/latest?symbols=\(to)&base=\(from)"
        performRequest(withUrlString: urlString)
    }
    private func performRequest (withUrlString urlString: String) {
        
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            if let currentRate = self.parseJSON(withData: data) {
                self.onCompletion?(currentRate)
            }
        }
        task.resume()
    }
    
    func parseJSON(withData data: Data) -> CurrentCalculator? {
       let decoder = JSONDecoder()
        
        do {
            let calculatorData = try decoder.decode(CalculatorData.self, from: data)
            guard let calculator = CurrentCalculator(calculatorData: calculatorData) else { return nil }
            return calculator
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
    
}

//
//  NetworkRateManager.swift
//  Rate
//
//  Created by Rotach Roman on 28.06.2020.
//  Copyright © 2020 Roman. All rights reserved.
//

import Foundation


class NetworkRateManager {
    
    var onCompletion: ((CurrentRate) -> Void )?
    
    func fetchCurrentRate(currency: String){
        let urlString = "https://api.exchangeratesapi.io/latest?base=\(currency)"
        performRequest(withUrlString: urlString)
    }
    
    private func performRequest (withUrlString urlString: String) {
        
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            if let currentRate = self.parseJSON(withData: data){
                self.onCompletion?(currentRate)
            }
        }
        task.resume()
    }
    
    func parseJSON(withData data: Data) -> CurrentRate? {
        let decoder = JSONDecoder()
        do {
            let currentRateData = try decoder.decode(CurrentRateData.self, from: data)
            guard let curretnRate = CurrentRate(currentRateData: currentRateData) else
            { return nil }
            
            return curretnRate
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}


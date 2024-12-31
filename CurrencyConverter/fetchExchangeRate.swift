//
//  fetchExchangeRate.swift
//  CurrencyConverter
//
//  Created by Pubudu Dilshan on 2024-12-31.
//

import Foundation


func fetchExchangeRate(from: String, to: String, completion: @escaping (Double?) -> Void) {
    let apiKey = "3f9ad98f40314b7a7466813b"  // API key http:exchangerate-api.com/
    let urlString = "https://v6.exchangerate-api.com/v6/3f9ad98f40314b7a7466813b/latest/USD"
    
    guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(ExchangeRateResponse.self, from: data)
                if let rate = decodedData.conversion_rates[to] {
                    completion(rate)
                } else {
                    completion(nil)
                }
            } catch {
                completion(nil)
            }
        }.resume()
    }

    // API Response structure with LKR included
    struct ExchangeRateResponse: Codable {
        let conversion_rates: [String: Double]
    }

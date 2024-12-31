//
//  CurrencyConverterViewModel.swift
//  CurrencyConverter
//
//  Created by Pubudu Dilshan on 2024-12-31.
//

import Foundation

class CurrencyConverterViewModel: ObservableObject {
    @Published var convertedAmount: String = ""
    
    func convertCurrency(amount: Double, from: String, to: String) {
        fetchExchangeRate(from: from, to: to) { rate in
            if let rate = rate {
                let result = amount * rate
                DispatchQueue.main.async {
                    self.convertedAmount = String(format: "%.2f", result)
                }
            } else {
                DispatchQueue.main.async {
                    self.convertedAmount = "Error fetching rate"
                }
            }
        }
    }
}


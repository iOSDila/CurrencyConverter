//
//  ContentView.swift
//  CurrencyConverter
//
//  Created by Pubudu Dilshan on 2024-12-31.
//

import SwiftUI

struct ContentView: View {
    @State private var amount = ""
    @State private var fromCurrency = "USD"
    @State private var toCurrency = "EUR"
    @State private var convertedAmount = ""
    @State private var isLoading = false
    
    let currencies = ["USD", "EUR", "GBP", "INR", "JPY" , "LKR"]
    
    @ObservedObject var viewModel = CurrencyConverterViewModel()

    var body: some View {
        VStack {
            Text("Currency Converter")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 40)
            
            HStack {
                Image(systemName: "dollarsign.circle.fill") // Icon for From Currency
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.blue)
                
                TextField("Enter amount", text: $amount)
                    .keyboardType(.decimalPad)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                
                Image(systemName: "eurosign.circle.fill") // Icon for To Currency
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.green)
            }
            .padding()
            
            Picker("From Currency", selection: $fromCurrency) {
                ForEach(currencies, id: \.self) { currency in
                    Text(currency).tag(currency)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding(.horizontal)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
            
            Picker("To Currency", selection: $toCurrency) {
                ForEach(currencies, id: \.self) { currency in
                    Text(currency).tag(currency)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding(.horizontal)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
            
            Button(action: {
                if let amountValue = Double(amount) {
                    isLoading = true
                    viewModel.convertCurrency(amount: amountValue, from: fromCurrency, to: toCurrency)
                }
            }) {
                Text("Convert")
                    .font(.title2)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
            .padding(.top, 20)
            
            if isLoading {
                // Spinner animation when loading
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .scaleEffect(2)
                    .padding(.top, 20)
            } else {
                Text("Converted Amount: \(convertedAmount)")
                    .font(.title2)
                    .padding(.top, 20)
                    .foregroundColor(.green)
            }
            
            Spacer()
        }
        .padding()
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.red, Color.purple]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
        )
        .cornerRadius(15)
        .shadow(radius: 10)
        .onChange(of: viewModel.convertedAmount) { _ in
            isLoading = false
            convertedAmount = viewModel.convertedAmount
        }
    }
}




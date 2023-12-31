//
//  ContentView.swift
//  WeSplit
//
//  Created by Goodwasp on 05.10.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 10
    
    private let tipPercentages = [5, 10, 15, 20, 0]
    
    private var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipValue = Double(tipPercentage)
        let total = checkAmount * ( 1 + tipValue / 100 )
        let amountPerPeople = total / peopleCount
        return amountPerPeople
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField(
                        "Check amount",
                        value: $checkAmount,
                        format: .currency(code: Locale.current.currency?.identifier ?? "USD")
                    )
                    .keyboardType(.decimalPad)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<20) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("How many tip do you want to leave?")
                }
                
                Section {
                    Text(
                        totalPerPerson,
                        format: .currency(code: Locale.current.currency?.identifier ?? "USD")
                    )
                } header: {
                    Text("Every person should pay")
                }
            }
            .navigationTitle("We Split")
        }
    }
}

#Preview {
    ContentView()
}

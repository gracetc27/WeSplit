//
//  ContentView.swift
//  WeSplit
//
//  Created by Grace couch on 16/07/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipAmount = 20
    @FocusState var isFocused: Bool

    var tip = [0, 5, 10, 15, 20, 25, 30]
    var grandTotal: Double {
        let tipSelection = Double(tipAmount)

        let tipValue = checkAmount / 100 * tipSelection
        let total = checkAmount + tipValue
        return total
    }
    var amountPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let totalPerPerson = grandTotal / peopleCount
        return totalPerPerson
    }
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "GBP"))
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<50) {
                            Text("\($0) people")
                        }
                    }
                }
                Section("Tip Percentage") {
                    Picker("Tip Percentage", selection: $tipAmount) {
                        ForEach(0...100, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(NavigationLinkPickerStyle())
                }
                Section("Grand total") {
                    Text(grandTotal, format: .currency(code: Locale.current.currency?.identifier ?? "GBP"))
                }
                Section("Amount Per Person") {
                    Text(amountPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "GBP"))

                }
            } .navigationTitle("WeSplit")
                .toolbar {
                    if isFocused {
                        Button("Done") {
                            isFocused = false
                        }
                    }
                }
        }
    }
}
#Preview {
    ContentView()
}

//
//  NumberInputView.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 28.03.25.
//
import SwiftUI


struct IntegerInputView: View {
	@Binding var number: Int
	let maxValue: Int
	let placeholder: String
	
	@State private var inputText: String = ""
	
	init(number: Binding<Int>, maxValue: Int, placeholder: String = "Enter a number") {
		self._number = number
		self.maxValue = maxValue
		self.placeholder = placeholder
		self._inputText = State(initialValue: String(number.wrappedValue))
	}
	
	var body: some View {
		TextField(placeholder, text: $inputText)
			.keyboardType(.numberPad)
			.onChange(of: inputText) { oldValue, newValue in
				let filtered = newValue.filter { "0123456789".contains($0) }
				if filtered != newValue {
					inputText = filtered
				}
				if let value = Int(filtered) {
					number = min(value, maxValue)
					inputText = String(number)
				} else if filtered.isEmpty {
					number = 0
					inputText = ""
				}
			}
			.onChange(of: number) { oldValue, newValue in
				inputText = String(newValue)
			}
	}
}

struct DoubleInputView: View {
	@Binding var number: Double
	let maxValue: Double
	let placeholder: String
	let decimalPlaces: Int
	
	@State private var inputText: String = ""
	
	init(number: Binding<Double>, maxValue: Double, placeholder: String = "Enter a number", decimalPlaces: Int = 2) {
		self._number = number
		self.maxValue = maxValue
		self.placeholder = placeholder
		self.decimalPlaces = decimalPlaces
		self._inputText = State(initialValue: String(format: "%.\(decimalPlaces)f", number.wrappedValue))
	}
	
	var body: some View {
		TextField(placeholder, text: $inputText)
			.keyboardType(.decimalPad)
			.onChange(of: inputText) { oldValue, newValue in
				let filtered = newValue.filter { "0123456789.".contains($0) }
				
				// Ensure only one decimal point
				if filtered.filter({ $0 == "." }).count > 1 {
					inputText = oldValue
					return
				}
				
				if filtered != newValue {
					inputText = filtered
				}
				
				if let value = Double(filtered) {
					number = min(value, maxValue)
					inputText = String(format: "%.\(decimalPlaces)f", number)
				} else if filtered.isEmpty {
					number = 0
					inputText = ""
				}
			}
			.onChange(of: number) { oldValue, newValue in
				inputText = String(format: "%.\(decimalPlaces)f", newValue)
			}
	}
}


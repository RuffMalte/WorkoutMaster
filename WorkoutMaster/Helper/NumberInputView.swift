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
	@State private var isEditing: Bool = false
	
	private let formatter: NumberFormatter
	
	init(number: Binding<Double>, maxValue: Double, placeholder: String = "Enter a number", decimalPlaces: Int = 2) {
		self._number = number
		self.maxValue = maxValue
		self.placeholder = placeholder
		self.decimalPlaces = decimalPlaces
		
		// Configure the NumberFormatter for locale-specific formatting
		let formatter = NumberFormatter()
		formatter.locale = Locale.current // Use the current locale
		formatter.numberStyle = .decimal
		formatter.maximumFractionDigits = decimalPlaces
		formatter.minimumFractionDigits = decimalPlaces
		self.formatter = formatter
		
		self._inputText = State(initialValue: formatter.string(from: NSNumber(value: number.wrappedValue)) ?? "")
	}
	
	var body: some View {
		TextField(placeholder, text: $inputText, onEditingChanged: { editing in
			isEditing = editing
			if !editing {
				// Validate and update the number when editing ends
				if let value = formatter.number(from: inputText)?.doubleValue, value <= maxValue {
					number = value
					inputText = formatter.string(from: NSNumber(value: number)) ?? ""
				} else {
					inputText = formatter.string(from: NSNumber(value: number)) ?? ""
				}
			}
		})
		.keyboardType(.decimalPad)
		.onChange(of: inputText) { oldValue, newValue in
			guard isEditing else { return }
			
			// Allow incomplete inputs (e.g., "123," or "0,")
			let filtered = newValue.filter { "0123456789,".contains($0) }
			
			// Ensure only one decimal separator exists (localized for the current locale)
			if filtered.filter({ $0 == formatter.decimalSeparator.first }).count > 1 || filtered != newValue {
				inputText = filtered
			}
		}
		.onChange(of: number) { oldValue, newValue in
			guard !isEditing else { return }
			inputText = formatter.string(from: NSNumber(value: newValue)) ?? ""
		}
	}
}




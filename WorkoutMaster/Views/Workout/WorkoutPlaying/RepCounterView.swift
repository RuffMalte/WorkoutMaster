//
//  RepCounterView.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 30.03.25.
//

import SwiftUI

struct RepCounterView: View {
	let currentSetIndex: Int
	let totalSets: Int
	let completedReps: Int
	let totalReps: Int
	let amountOfWeight: Double
	let onIncrement: () -> Void
	let onDecrement: () -> Void
	
	var body: some View {
		ZStack {
			HStack {
				Text("Set \(currentSetIndex + 1) of \(totalSets)")
					
				Spacer()
				
				if amountOfWeight > 0 {
					Text(amountOfWeight.description + " Kg")
				} else {
					Text("Bodyweight")
				}
			}
			.font(.system(.subheadline, design: .rounded, weight: .medium))
			.foregroundStyle(.secondary)
			
			VStack {
				Text("Completed Reps")
					.font(.system(.footnote, design: .rounded, weight: .medium))
				
				
				HStack {
					Button {
						withAnimation {
							onDecrement()
						}
					} label: {
						Image(systemName: "minus.circle.fill")
							.font(.title2)
					}
					.buttonStyle(.plain)
					
					Text("\(completedReps)" + "/" + "\(totalReps)")
						.font(.system(.title2, design: .monospaced, weight: .bold))
					
					Button {
						withAnimation {
							onIncrement()
						}
					} label: {
						Image(systemName: "plus.circle.fill")
							.font(.title2)
					}
					.buttonStyle(.plain)
				}
			}
			
			Spacer()

		}
	}
}

#Preview {
	RepCounterView(currentSetIndex: 0, totalSets: 12, completedReps: 12, totalReps: 20, amountOfWeight: 22.3) {
		print("increment")
	} onDecrement: {
		print("decrement")

	}
}

//
//  WorkoutSetView.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 28.03.25.
//

import SwiftUI

struct ModifyWorkoutSetItemView: View {
	
	@Bindable var exerciseSet: WorkoutSetModel
	var onDelete: () -> Void
	
	
    var body: some View {
		HStack {

			HStack {
				
				HStack {
					DoubleInputView(number: $exerciseSet.weight, maxValue: 9999, placeholder: "Weight")
						.font(.system(.headline, design: .monospaced, weight: .regular))
					Spacer()
					Text("kg")
						.font(.subheadline)
						.foregroundStyle(.secondary)
				}
				.barColoredRoundedBackground()
				
				Spacer()
				
				HStack {
					IntegerInputView(number: $exerciseSet.reps, maxValue: 9999, placeholder: "Reps")
						.font(.system(.headline, design: .monospaced, weight: .regular))
					Spacer()
					Text("reps")
						.font(.subheadline)
						.foregroundStyle(.secondary)
				}
				.barColoredRoundedBackground()
				
				Spacer()
				
				
				Button(role: .destructive) {
					onDelete()
				} label: {
					Image(systemName: "minus.circle")
						.font(.headline)
					
				}
				
			}
		}
		
		
    }
}

#Preview {
	ModifyWorkoutSetItemView(exerciseSet: WorkoutSetModel.preview) {
		print("Delete")
	}
}

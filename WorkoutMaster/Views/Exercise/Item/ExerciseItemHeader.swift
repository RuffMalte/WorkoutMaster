//
//  ExerciseItemHeader.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 28.03.25.
//

import SwiftUI

struct ExerciseItemHeader: View {
	
	@Bindable var exercise: ExerciseModel
	
	var body: some View {
		HStack {
			RoundedRectangle(cornerRadius: 10)
				.frame(width: 40, height: 40)
				.foregroundStyle(.bar)
			
			VStack(alignment: .leading) {
				Text(exercise.name)
					.font(.system(.headline, design: .rounded, weight: .bold))
				
				if !exercise.formatedEquipment.isEmpty {
					Text(exercise.formatedEquipment)
						.font(.system(.subheadline, design: .rounded, weight: .medium))
						.foregroundStyle(.secondary)
				}
			}
			
			Spacer()
		}
	}
}

#Preview {
	ExerciseItemHeader(exercise: ExerciseModel.preview)
}

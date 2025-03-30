//
//  NextExerciseInfoView.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 30.03.25.
//

import SwiftUI

struct NextExerciseInfoView: View {
	let nextExercise: ExerciseModel?
	let caloriesBurned: Int
	
	var body: some View {
		HStack {
			VStack(alignment: .leading) {
				Text("Next Exercise")
					.font(.system(.footnote, design: .rounded, weight: .medium))
				
				if let nextExercise = nextExercise {
					ExerciseItemHeader(exercise: nextExercise)
				} else {
					Text("None")
						.font(.system(.headline, design: .rounded, weight: .bold))

				}
			}
			Spacer()
			
			VStack(alignment: .leading) {
				Text("Calories Burned")
					.font(.system(.footnote, design: .rounded, weight: .medium))
				
				Text("\(caloriesBurned)")
					.font(.system(.headline, design: .monospaced, weight: .bold))
			}
		}
	}
}


#Preview {
	NextExerciseInfoView(nextExercise: ExerciseModel.preview, caloriesBurned: 400)
}

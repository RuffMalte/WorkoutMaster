//
//  CurrentExerciseView.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 30.03.25.
//

import SwiftUI

struct CurrentExerciseView: View {
	let exerciseName: String
	
	var body: some View {
		VStack {
			Circle()
				.foregroundStyle(.clear)
				.padding(.horizontal, 40)
				.overlay {
					Text(exerciseName)
				}
		}
	}
}


#Preview {
	CurrentExerciseView(exerciseName: "Name")
}

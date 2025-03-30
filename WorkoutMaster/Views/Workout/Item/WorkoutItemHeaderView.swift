//
//  WorkoutItemHeaderView.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 30.03.25.
//

import SwiftUI

struct WorkoutItemHeaderView: View {
	
	@Bindable var workout: WorkoutModel
	
    var body: some View {
		VStack(alignment: .leading) {
			Text(workout.name)
				.font(.system(.headline, design: .rounded, weight: .bold))
			
			Text(workout.calculatedSetsAndExercises)
				.font(.system(.subheadline, weight: .semibold))
				.foregroundStyle(.secondary)
			Divider()
		}
    }
}

#Preview {
	WorkoutItemHeaderView(workout: WorkoutModel.preview)
}

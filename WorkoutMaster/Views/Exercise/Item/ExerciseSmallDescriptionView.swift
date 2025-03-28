//
//  ExerciseSmallDescriptionView.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 28.03.25.
//

import SwiftUI

struct ExerciseSmallDescriptionView: View {
	let title: String
	let variable: String
	
	var body: some View {
		if !variable.isEmpty {
			HStack {
				VStack(alignment: .leading) {
					Text(title)
						.font(.system(.subheadline, design: .rounded, weight: .medium))
						.foregroundStyle(.secondary)
					Text(variable)
						.font(.system(.headline, design: .rounded, weight: .bold))
				}
				Spacer()
			}
		}
	}
}

#Preview {
	var variable: String = "abc"
	
	ExerciseSmallDescriptionView(title: "test", variable: variable)
}

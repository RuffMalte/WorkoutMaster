//
//  CurrentExerciseView.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 30.03.25.
//

import SwiftUI

struct CurrentExerciseView: View {
	let exercise: ExerciseModel
	let completedReps: Int
	let totalReps: Int
	
	var body: some View {
		VStack(spacing: 15) {
			// Progress Circle with Image Placeholder
			ZStack {
				// Background Circle
				Circle()
					.stroke(lineWidth: 8)
					.foregroundColor(.gray.opacity(0.2))
				
				// Progress Circle
				Circle()
					.trim(from: 0, to: CGFloat(completedReps) / CGFloat(totalReps))
					.stroke(
						style: StrokeStyle(
							lineWidth: 8,
							lineCap: .round,
							lineJoin: .round
						)
					)
					.foregroundColor(.blue)
					.rotationEffect(.degrees(-90))
				
				//TODO: Image placeholder
				RoundedRectangle(cornerRadius: RadiusConstants.medium)
					.frame(width: 100, height: 100)
					.foregroundColor(.secondary.opacity(0.2))
			}
			.frame(width: 180, height: 180)
			.padding(.vertical, PaddingConstants.small)
			
			VStack(spacing: 8) {
				Text(exercise.name)
					.font(.title2.weight(.bold))
				
				HStack(spacing: 15) {
					Label(exercise.category.rawValue.capitalized, systemImage: "tag.fill")
					Label(exercise.bodyPart.rawValue.capitalized, systemImage: "figure.arms.open")
				}
				.font(.subheadline)
				.foregroundStyle(.secondary)
				
				if !exercise.equipment.isEmpty {
					Label(
						exercise.equipment.map { $0.name }.joined(separator: ", "),
						systemImage: "hammer.fill"
					)
					.font(.subheadline)
					.foregroundStyle(.teal)
				}
				
				if !exercise.explanation.isEmpty {
					Text(exercise.explanation)
						.font(.caption)
						.foregroundStyle(.secondary)
						.multilineTextAlignment(.center)
						.padding(.top, PaddingConstants.small)
				}
			}
		}
		.padding()
	}
}



#Preview {
	CurrentExerciseView(exercise: ExerciseModel.preview, completedReps: 2, totalReps: 12)
}

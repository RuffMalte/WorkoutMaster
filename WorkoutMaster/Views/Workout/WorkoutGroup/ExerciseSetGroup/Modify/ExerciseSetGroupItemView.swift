//
//  ExerciseSetGroupItemView.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 28.03.25.
//

import SwiftUI

struct ModifyExerciseSetGroupItemView: View {
	
	@Bindable var setGroup: ExerciseSetGroupModel
	var onDelete: () -> Void

    var body: some View {
		VStack(spacing: 10) {
			HStack {
				ExerciseItemHeader(exercise: setGroup.exercise)
				Spacer()
				Button(role: .destructive) {
					onDelete()
				} label: {
					Image(systemName: "trash.circle.fill")
						.font(.title2)
				}
				
			}
			
			Divider()
			
			ForEach(setGroup.sets) { set in
				ModifyWorkoutSetItemView(exerciseSet: set) {
					setGroup.sets.remove(at: setGroup.sets.firstIndex(of: set)!)
				}
				
				
				
			}
			
			Button {
				withAnimation {
					if let lastItem = setGroup.sets.last {
						let newLastItem = WorkoutSetModel()
						newLastItem.reps = lastItem.reps
						newLastItem.weight = lastItem.weight
						newLastItem.duration = lastItem.duration
						
						setGroup.sets.append(newLastItem)
						
					} else {
						setGroup.sets.append(WorkoutSetModel.newModel)
					}
				}
			} label: {
				Text("Add set")
					.centeredHStack()
			}
			.buttonStyle(.plain)
			.barColoredPillBackground()
		}
		.padding()
		.background(
			RoundedRectangle(cornerRadius: RadiusConstants.medium)
				.foregroundStyle(Color.adaptiveBlackWhite)
//				.shadow(radius: 3)
		)
    }
}

#Preview {
	ModifyExerciseSetGroupItemView(setGroup: ExerciseSetGroupModel.preview) {
		print("delete")
	}
}

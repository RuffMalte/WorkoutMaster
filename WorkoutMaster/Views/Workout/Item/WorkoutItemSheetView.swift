//
//  WorkoutItemSheetView.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 28.03.25.
//

import SwiftUI

struct WorkoutItemSheetView: View {
	
	@Bindable var workout: WorkoutModel
	
	@State private var isShowingEditWorkoutSheet: Bool = false
	
    var body: some View {
		VStack(alignment: .leading) {
			Text(workout.name)
				.font(.system(.headline, design: .rounded, weight: .bold))
			
			Text(workout.calculatedSetsAndExercises)
				.font(.system(.subheadline, weight: .semibold))
				.foregroundStyle(.secondary)
			
			Divider()
			
			
			VStack {
				ScrollView(.vertical) {
					ForEach(workout.groups) { group in
						VStack(alignment: .leading) {
							Text(group.name)
								.font(.system(.headline, design: .rounded, weight: .bold))

							HStack {
								Divider()
									.coloredPillBackground(.random(), padding: 2)
									.frame(width: 2)
									.padding(2)
								
								VStack {
									ForEach(group.setGroups) { setGroup in
										
										VStack(alignment: .leading) {
											ExerciseItemHeader(exercise: setGroup.exercise)
											
											Text(setGroup.repsSetsAsString)
												.font(.system(.subheadline, design: .rounded, weight: .medium))
												.foregroundStyle(.secondary)
										}
									}
								}
								.coloredRoundedBackground(Color.adaptiveBlackWhite)
								
								Spacer()
								
							}
							
						}
					}
				}
			}
			
			
			HStack {
				
				Button {
					
				} label: {
					Label("Start Workout", systemImage: "play.fill")
						.foregroundStyle(.primary)
						.font(.system(.headline, design: .rounded, weight: .bold))
				}
				.centeredHStack()
				.coloredPillBackground(.green)
				.buttonStyle(.plain)
				
				Button {
					isShowingEditWorkoutSheet.toggle()
				} label: {
					Label("Edit", systemImage: "pencil")
						.font(.system(.headline, design: .rounded, weight: .bold))
						.foregroundStyle(.primary)
				}
				.coloredPillBackground(Color.adaptiveBlackWhite)
				.buttonStyle(.plain)
				
			}
			
			
		}
		.padding()
		.background(.bar)
		.sheet(isPresented: $isShowingEditWorkoutSheet) {
			ModifyWorkoutSheetView(workout: workout, isNewWorkout: false)
		}
    }
}

#Preview {
	WorkoutItemSheetView(workout: WorkoutModel.preview)
}

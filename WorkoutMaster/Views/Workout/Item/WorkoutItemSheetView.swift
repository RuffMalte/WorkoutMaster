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
	@State private var isShowingWorkout: Bool = false
	
    var body: some View {
		VStack(alignment: .leading) {
			WorkoutItemHeaderView(workout: workout)
			
			VStack {
				ScrollView(.vertical) {
					ForEach(workout.groups) { group in
						VStack(alignment: .leading) {
							Text(group.name)
								.font(.system(.subheadline, design: .rounded, weight: .bold))

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
					isShowingWorkout.toggle()
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
		.fullScreenCover(isPresented: $isShowingWorkout) {
			WorkoutPlayingView(workout: workout)
		}
		.presentationDragIndicator(.visible)
    }
}

#Preview {
	WorkoutItemSheetView(workout: WorkoutModel.preview)
}

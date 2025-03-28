//
//  WorkoutView.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 28.03.25.
//

import SwiftUI
import SwiftData

struct WorkoutView: View {
	
	@State private var isShowingExerciseSheetView: Bool = false
	@State private var isShowingAddWorkoutSheetView: Bool = false
	
	@Query(sort: \WorkoutModel.name) var workouts: [WorkoutModel]
	@Environment(\.modelContext) var modelContext
	
    var body: some View {
		NavigationStack {
			ScrollView(.vertical) {
				VStack {
					ForEach(workouts) { workout in
						WorkoutItemListView(workout: workout)
							
					}
					
					Button {
						isShowingAddWorkoutSheetView.toggle()
					} label: {
					
						Label("Add Workout plan", systemImage: "plus")
							.foregroundStyle(.white)
							.font(.system(.headline, design: .rounded, weight: .bold))
					}
					.centeredHStack()
					.buttonStyle(.plain)
					.coloredPillBackground(.accentColor)

				}
				.padding(.horizontal)
			}
			.background(.bar)
			.navigationTitle("Workouts")
			
			.sheet(isPresented: $isShowingExerciseSheetView) {
				ExercisesListView()
			}
			.sheet(isPresented: $isShowingAddWorkoutSheetView) {
				ModifyWorkoutSheetView(workout: WorkoutModel.preview, isNewWorkout: true)
			}
			
			.toolbar {
				ToolbarItem(placement: .primaryAction) {
					Button {
						isShowingExerciseSheetView.toggle()
					} label: {
						Image(systemName: "figure.run.square.stack")
							.fontWeight(.bold)
					}
				}
				
				ToolbarItem(placement: .primaryAction) {
					Button {
						isShowingAddWorkoutSheetView.toggle()
					} label: {
						Image(systemName: "plus")
							.fontWeight(.bold)
					}

				}
			}
			
		}
    }
}

#Preview {
    WorkoutView()
		.modelContainer(previewContainer)
}

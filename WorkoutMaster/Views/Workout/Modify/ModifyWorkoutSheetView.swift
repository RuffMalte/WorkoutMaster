//
//  ModifyWorkoutSheetView.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 28.03.25.
//

import SwiftUI
import SwiftData

struct ModifyWorkoutSheetView: View {
	
	@Bindable var workout: WorkoutModel
	var isNewWorkout: Bool
	
	@Query(sort: \WorkoutModel.name) var workouts: [WorkoutModel]
	@Environment(\.modelContext) var modelContext
	@Environment(\.dismiss) var dismiss
	
    var body: some View {
		NavigationStack {
			VStack {
				
				VStack(alignment: .leading) {
					TextField(workout.name, text: $workout.name)
						.font(.system(.title3, design: .rounded, weight: .bold))
					
					Text(workout.calculatedSetsAndExercises)
						.font(.system(.subheadline, design: .rounded, weight: .medium))
					
				}
				
				Divider()
				
				ScrollView(.vertical) {
					
					ForEach(workout.groups) { group in
						ModifyWorkoutGroupItemView(group: group) {
							withAnimation {
								self.workout.groups.append(group.copy())
							}
						} onDelete: {
							workout.groups.remove(at: workout.groups.firstIndex(of: group) ?? 0)
						}
						.padding(.vertical, PaddingConstants.small)
					}
					
					Button {
						withAnimation {
							workout.groups.append(WorkoutGroupModel.preview)
						}
					} label: {
						Label("Add new Group", systemImage: "rectangle.3.group.fill")
							.fontWeight(.bold)
							.foregroundStyle(.white)
							.centeredHStack()
					}
					.coloredPillBackground(.accentColor)
					
					
					
					
				}
				
			}
			.padding()
			.background(.bar)
			
			.toolbar {
				
				ToolbarItem(placement: .primaryAction) {
					Button {
						if isNewWorkout {
							modelContext.insert(workout)
						}
						try? modelContext.save()
						
						dismiss()
					} label: {
						Text("Save")
					}

				}
				
				
				ToolbarItem(placement: .cancellationAction) {
					Button {
						dismiss()
					} label: {
						Text("Cancel")
					}
					
				}
				
			}
			
		}
    }
}

#Preview {
	ModifyWorkoutSheetView(workout: WorkoutModel.preview, isNewWorkout: false)
		.modelContainer(previewContainer)
}

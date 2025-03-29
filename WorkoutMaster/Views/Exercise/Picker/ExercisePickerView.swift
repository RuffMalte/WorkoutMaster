//
//  ExercisePickerView.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 29.03.25.
//

import SwiftUI
import SwiftData

struct ExercisePickerView: View {
	
	var onSave: ([ExerciseModel]) -> Void
	
	@Query(sort: \ExerciseModel.name) var exercises: [ExerciseModel]
	@Environment(\.modelContext) var modelContext

	@State var selectedExercises: [ExerciseModel] = []
	@State private var isShowingAddExerciseView: Bool = false

	@Environment(\.dismiss) var dismiss
	var body: some View {
		
		NavigationStack {
			VStack {
				ScrollView(.vertical) {
					
					Button {
						 isShowingAddExerciseView.toggle()
					} label: {
						Label("Add Exercise", systemImage: "plus")
							.fontWeight(.bold)
							.foregroundStyle(.white)
							.centeredHStack()
					}
					.coloredPillBackground(.accentColor)
					
					ForEach(exercises) { exercise in
						HStack {
							ExerciseItemListView(exercise: exercise)
							
							
							Button {
								withAnimation {
									if let index = selectedExercises.firstIndex(of: exercise) {
										// Exercise already exists, so remove it
										selectedExercises.remove(at: index)
									} else {
										// Exercise doesn't exist, so add it
										selectedExercises.append(exercise)
									}
								}
							} label: {
								Image(systemName: selectedExercises.contains(exercise) ? "checkmark.square.fill" : "square")
									.font(.title2)
							}

							
						}
							.coloredRoundedBackground(Color.adaptiveBlackWhite, padding: PaddingConstants.medium)
					}
				}
			}
			.padding()
			.navigationTitle("Exercises")
			.background(.bar)
			.toolbar {
				ToolbarItem(placement: .primaryAction) {
					Button {
						onSave(selectedExercises)
						dismiss()
					} label: {
						Text("Add")
					}
				}
				
				ToolbarItem(placement: .cancellationAction) {
					Button(role: .cancel) {
						dismiss()
					} label: {
						Text("Cancel")
					}
				}
			}
			
			
			.sheet(isPresented: $isShowingAddExerciseView) {
				ModifyExerciseSheetView(exercise: ExerciseModel.newModel, isNewExercise: true)
			}
		}
    }
}

#Preview {
	ExercisePickerView(onSave: { models in
		for model in models {
			print("\(model.name)")
		}
	})
	.modelContainer(previewContainer)
}

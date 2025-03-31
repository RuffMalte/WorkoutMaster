//
//  ExercisesListView.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 28.03.25.
//

import SwiftUI
import SwiftData

struct ExercisesListView: View {
	
	@Query(sort: \ExerciseModel.name) var exercises: [ExerciseModel]
	@Environment(\.modelContext) var modelContext

	
	@State private var isShowingAddExerciseView: Bool = false
	
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
						ExerciseItemListView(exercise: exercise)
							.coloredRoundedBackground(Color.adaptiveBlackWhite, padding: PaddingConstants.medium)
					}
				}
			}
			.presentationDragIndicator(.visible)
			.padding()
			.navigationTitle("Exercises")
			.background(.bar)
			.toolbar {
				ToolbarItem(placement: .primaryAction) {
					Button {
						isShowingAddExerciseView.toggle()
					} label: {
						Image(systemName: "plus")
							.fontWeight(.bold)
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
    ExercisesListView()
		.modelContainer(previewContainer)

}

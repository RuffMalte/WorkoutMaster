//
//  ExerciseItemSheetView.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 28.03.25.
//

import SwiftUI
import SwiftData

struct ExerciseItemSheetView: View {
	
	@Bindable var exercise: ExerciseModel
	
	@Query(sort: \ExerciseModel.name) var exercises: [ExerciseModel]
	@Environment(\.modelContext) var modelContext

	@Environment(\.dismiss) var dismiss
	@State private var isShowingModifySheet: Bool = false
	
    var body: some View {
		VStack {
			
			HStack {
				ExerciseItemHeader(exercise: exercise)
				Spacer()
			}
				
			Divider()
			
			VStack(spacing: 10) {
				ExerciseSmallDescriptionView(title: "Explanation", variable: exercise.explanation)
				
				HStack {
					ExerciseSmallDescriptionView(title: "Primary Bodypart", variable: exercise.bodyPart.rawValue.capitalized)
					
					ExerciseSmallDescriptionView(title: "Category", variable: exercise.category.rawValue.capitalized)
				}
				
			}
			.padding(.top)
			
			Spacer()
			
			HStack {
				Button {
					isShowingModifySheet.toggle()
				} label: {
					Label("Edit", systemImage: "pencil")
						.centeredHStack()
						
						.fontWeight(.bold)
				}
				.barColoredPillBackground()
				.buttonStyle(.plain)
				
				Button {
					dismiss()
					modelContext.delete(exercise)
				} label: {
					Label("Delete", systemImage: "trash.fill")
						.foregroundStyle(.white)
						.fontWeight(.bold)
				}
				.coloredPillBackground(.red)

			}
		
			
		}
		.sheet(isPresented: $isShowingModifySheet) {
			ModifyExerciseSheetView(exercise: exercise, isNewExercise: false)
		}
    }
}

#Preview {
	ExerciseItemSheetView(exercise: ExerciseModel.preview)
		.padding()
}

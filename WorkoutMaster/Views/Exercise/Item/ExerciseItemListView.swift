//
//  ExerciseItemListView.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 28.03.25.
//

import SwiftUI

struct ExerciseItemListView: View {
	
	@Bindable var exercise: ExerciseModel
	
	@State private var isShowingDetails: Bool = false
	
    var body: some View {
		HStack {
			
			ExerciseItemHeader(exercise: exercise)
			
			Spacer()
			
			
			Button {
				isShowingDetails.toggle()
			} label: {
				Image(systemName: "info.circle")
			}
			.buttonStyle(.plain)
			.foregroundStyle(.secondary)

		}
		.sheet(isPresented: $isShowingDetails) {
			ExerciseItemSheetView(exercise: exercise)
				.padding()
				.presentationDetents([.fraction(0.3)])
		}
		
    }
}

#Preview {
	ExerciseItemListView(exercise: ExerciseModel.preview)
}

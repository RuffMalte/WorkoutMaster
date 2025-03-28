//
//  WorkoutItemListView.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 28.03.25.
//

import SwiftUI

struct WorkoutItemListView: View {
	
	@Bindable var workout: WorkoutModel
	
	@State private var isShowingDetails: Bool = false
	
    var body: some View {
		Button {
			isShowingDetails.toggle()
		} label: {
			HStack {
				VStack(alignment: .leading) {
					Text(workout.name)
						.font(.system(.headline, design: .rounded, weight: .bold))
					Text(workout.calculatedSetsAndExercises)
						.font(.system(.subheadline, design: .rounded, weight: .medium))
						.foregroundStyle(.secondary)
				}
				Spacer()
				
				Image(systemName: "chevron.right")
				
			}
			.padding()
			.background() {
				RoundedRectangle(cornerRadius: 10)
					.foregroundStyle(Color.adaptiveBlackWhite)
			}
		}
		.buttonStyle(.plain)
		
		.sheet(isPresented: $isShowingDetails) {
			WorkoutItemSheetView(workout: workout)
			.presentationDetents( [.medium, .large])
		}
    }
}

#Preview {
	WorkoutItemListView(workout: WorkoutModel.preview)
		.background(.bar)
}

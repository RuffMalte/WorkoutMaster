//
//  WorkoutView.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 28.03.25.
//

import SwiftUI

struct WorkoutView: View {
	
	@State private var isShowingExerciseSheetView: Bool = false
	
    var body: some View {
		NavigationStack {
			ScrollView(.vertical) {
				VStack {
					ForEach(1...3, id: \.self) { int in
						WorkoutItemListView()
							
					}
					
					Button {
						
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
}

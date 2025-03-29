//
//  WorkoutGroupItemView.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 28.03.25.
//

import SwiftUI

struct ModifyWorkoutGroupItemView: View {
	
	@Bindable var group: WorkoutGroupModel
	var onDuplicate: () -> Void
	var onDelete: () -> Void
	
	@State private var randomColor: Color = .random()

	@State private var isShowingExersicePicker: Bool = false
	
    var body: some View {
		VStack(alignment: .leading) {
			
			HStack {
				TextField("Group Name", text: $group.name)
					.font(.system(.headline, design: .rounded, weight: .bold))
				
				Spacer()
				
				Menu {
					Button {
						onDuplicate()
					} label: {
						Label("Duplicate this Group", systemImage: "square.filled.on.square")
					}
					Button(role: .destructive) {
						onDelete()
					} label: {
						Label("Delete this Group", systemImage: "trash.fill")
					}
				} label: {
					Image(systemName: "line.3.horizontal.circle.fill")
						.fontWeight(.bold)
						.font(.headline)

				}
				
			}
			
			HStack() {
				HStack {
					Divider()
						.frame(width: 1)
						.coloredPillBackground(randomColor, padding: 2)
				}
				
				VStack(spacing: 20) {
					ForEach(group.setGroups) { setGroup in
						ModifyExerciseSetGroupItemView(setGroup: setGroup) {
							group.setGroups.remove(at: group.setGroups.firstIndex(of: setGroup)!)
						}
						
					}
					
					Button {
						isShowingExersicePicker.toggle()
//						withAnimation {
//							group.setGroups.append(ExerciseSetGroupModel.preview)
//						}
					} label: {
						Label("Add exercise", systemImage: "plus")
							.foregroundStyle(.primary)
							.fontWeight(.bold)
							.centeredHStack()
					}
					.coloredPillBackground(.secondary)
					.buttonStyle(.plain)
				}
				.padding(.horizontal, PaddingConstants.small)
				
				Spacer()
			}
		}
		.sheet(isPresented: $isShowingExersicePicker) {
			ExercisePickerView { selectedExercises in
				for exercise in selectedExercises {
					let newSetGroup = ExerciseSetGroupModel(
						exercise: exercise,
						sets: []
					)
					group.setGroups.append(newSetGroup)
				}
			}
		}
    }
}

#Preview {
	ModifyWorkoutGroupItemView(group: WorkoutGroupModel.preview, onDuplicate: {
		print("duplicate")
	}, onDelete: {
		print("delete")
	})
	.padding()
}

//
//  ModifyExerciseSheetView.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 28.03.25.
//

import SwiftUI
import SwiftData

struct ModifyExerciseSheetView: View {
	
	@Bindable var exercise: ExerciseModel
	var isNewExercise: Bool
	
	@Environment(\.dismiss) var dismiss
	@Query(sort: \ExerciseModel.name) var exercises: [ExerciseModel]
	@Environment(\.modelContext) var modelContext
	
	@State private var isShowingMetInfo: Bool = false
	
    var body: some View {
		NavigationStack {
			Form {
				
				Section {
					
					HStack {
						TextField("Name", text: $exercise.name)
						Spacer()
						Image(systemName: "pencil")
					}
					.font(.system(.headline, design: .rounded, weight: .bold))
					
				} header: {
					Text("Name")
				}
				
				
				Section {
					TextEditor(text: $exercise.explanation)
						.lineLimit(3)
				} header: {
					Text("Explanation")
				}
				
				
				Section {
					Picker("Exercise Category", selection: $exercise.category) {
						ForEach(ExerciseCategory.allCases, id: \.self) { category in
							Text(category.rawValue.capitalized)
								.tag(category)
						}
					}
					.pickerStyle(.automatic)
					
					
					Picker("Bodypart", selection: $exercise.bodyPart) {
						ForEach(BodyPart.allCases, id: \.self) { category in
							Text(category.rawValue.capitalized)
								.tag(category)
						}
					}
					
				}
				
					ForEach(ExerciseEquipment.allCases, id: \.self) { equipment in
						Button(action: {
							toggleSelection(of: equipment)
						}) {
							HStack {
								Image(systemName: equipment.iconName)
								Text(equipment.rawValue.capitalized)
								Spacer()
								if exercise.equipment.contains(equipment) {
									Image(systemName: "checkmark")
										.foregroundColor(.blue)
								}
							}
						}
						.foregroundColor(.primary)
					}
				
				Section {
					DoubleInputView(number: $exercise.metValue, maxValue: 20, placeholder: "MET value", decimalPlaces: 2)
				} header: {
					HStack {
						Text("MET Value")
						Spacer()
						Button {
							isShowingMetInfo.toggle()
						} label: {
							Image(systemName: "info.circle")
								.font(.subheadline)
						}
						.buttonStyle(.plain)
						.popover(isPresented: $isShowingMetInfo) {
							VStack {
								ScrollView(.vertical) {
									Text("A MET (Metabolic Equivalent of Task) is a measure used to indicate the intensity of an activity by comparing it to your resting energy expenditure. Specifically, 1 MET represents the amount of energy your body uses while sitting quietly. For example, an activity with a MET value of 4 means you’re burning four times the energy you would at rest")
										.textCase(nil)
								}
							}
							.presentationCompactAdaptation(.popover)
							.padding()
							.frame(height: 150)
							.font(.system(.footnote, design: .rounded, weight: .regular))

						}

					}
				}
				
				
			}
			.presentationDragIndicator(.visible)
			.toolbar {
				ToolbarItem(placement: .primaryAction) {
					Button {
						if isNewExercise {
							modelContext.insert(exercise)
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
	
	private func toggleSelection(of equipment: ExerciseEquipment) {
		if exercise.equipment.contains(equipment) {
			exercise.equipment.removeAll { $0 == equipment }
		} else {
			exercise.equipment.append(equipment)
		}
	}
}

#Preview {
	ModifyExerciseSheetView(exercise: ExerciseModel.preview, isNewExercise: true)
}

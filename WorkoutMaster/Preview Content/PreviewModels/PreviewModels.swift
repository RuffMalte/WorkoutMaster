//
//  PreviewModels.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 28.03.25.
//

import Foundation

extension ExerciseModel {
	
	
	static var preview: ExerciseModel {
		.init(
			name: "Name",
			category: .balance,
			bodyPart: .back)
	}
	
	static var newModel: ExerciseModel {
		return ExerciseModel(name: "", category: .balance, bodyPart: .chest)
	}
		
	static var previewItems: [ExerciseModel] {
		return [
			ExerciseModel(name: "Push-ups", category: .strength, bodyPart: .chest),
			ExerciseModel(name: "Squats", category: .cardio, bodyPart: .legs),
			ExerciseModel(name: "Plank", category: .flexibility, bodyPart: .core),
			ExerciseModel(name: "Lunges", category: .balance, bodyPart: .legs)
		]
	}
	
}

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

extension WorkoutModel {
	
	static var preview: WorkoutModel {
		let workout = WorkoutModel(name: "Workout Name")
		
		workout.groups.append(WorkoutGroupModel.preview)
		
		
		return workout
	}
	
	static var newModel: WorkoutModel {
		return WorkoutModel(name: "Name")
	}
	
	static var previewItems: [WorkoutModel] {
		return [
			WorkoutModel(name: "Hello"),
			WorkoutModel(name: "Hello 2"),
			WorkoutModel(name: "Hello 3"),
			WorkoutModel(name: "Hello 4")
		]
	}
}

extension WorkoutGroupModel {
	
	static var preview: WorkoutGroupModel {
		let group = WorkoutGroupModel(name: "Name 1", order: 1)
		
		group.setGroups.append(
			ExerciseSetGroupModel(
				exercise: ExerciseModel.preview,
				sets: [
					WorkoutSetModel.preview,
					WorkoutSetModel.preview,
					WorkoutSetModel.preview
				]
			)
		)
		
		
		return group
	}
	
	static var newModel: WorkoutGroupModel {
		return WorkoutGroupModel(name: "Group 1", order: 1)
	}
	
	static var previewItems: [WorkoutGroupModel] {
		return [
			.init(name: "name 1", order: 1),
			.init(name: "name 2", order: 2),
			.init(name: "name 3", order: 3),
			.init(name: "name 4", order: 4)
		]
	}
	
}

extension WorkoutSetModel {
	
	
	static var preview: WorkoutSetModel {
		return WorkoutSetModel(
			weight: 29, reps: 2, duration: TimeInterval.infinity)
	}
	
	static var newModel: WorkoutSetModel {
		return WorkoutSetModel(weight: 0, reps: 0, duration: 0)
	}
	
}

extension ExerciseSetGroupModel {
	
	static var preview: ExerciseSetGroupModel {
		return ExerciseSetGroupModel(
			exercise: ExerciseModel.preview,
			sets: [
				WorkoutSetModel.preview,
				WorkoutSetModel.preview,
				WorkoutSetModel.preview
			]
		)
	}
	
}

//
//  ExerciseSetGroupModel.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 28.03.25.
//

import Foundation
import SwiftData

@Model
class ExerciseSetGroupModel {
	var exercise: ExerciseModel
	var sets: [WorkoutSetModel]
	
	
	init(exercise: ExerciseModel, sets: [WorkoutSetModel]) {
		self.exercise = exercise
		self.sets = sets
	}
}



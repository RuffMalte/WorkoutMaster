//
//  ExerciseSetGroupModel.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 28.03.25.
//

import Foundation
import SwiftData

@Model
class ExerciseSetGroupModel: Identifiable {
	
	var id: UUID
	var exercise: ExerciseModel
	var sets: [WorkoutSetModel]
	
	
	init(exercise: ExerciseModel, sets: [WorkoutSetModel]) {
		self.id = UUID()
		self.exercise = exercise
		self.sets = sets
	}
	
	
	var totalReps: Int {
		sets.reduce(0) { $0 + $1.reps }
	}
	
	var totalSets: Int {
		sets.count
	}
	
	var repsSetsAsString: String {
		"\(totalSets) sets with \(totalReps) total reps"
	}
}



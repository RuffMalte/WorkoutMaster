//
//  WorkoutGroupModel.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 28.03.25.
//

import Foundation
import SwiftData

@Model
class WorkoutGroupModel {
	var id: UUID
	var name: String
	var order: Int
	var setGroups: [ExerciseSetGroupModel] = []
	
	@Relationship(deleteRule: .cascade) var workout: WorkoutModel?
	
	init(name: String, order: Int) {
		self.id = UUID()
		self.name = name
		self.order = order
	}
}

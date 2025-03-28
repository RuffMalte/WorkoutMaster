//
//  WorkoutGroupModel.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 28.03.25.
//

import Foundation
import SwiftData

@Model
class WorkoutGroupModel: Identifiable {
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
	
	
	func copy() -> WorkoutGroupModel {
		let new = WorkoutGroupModel(name: self.name, order: self.order)
		
		new.setGroups = self.setGroups.map(\.self)
		new.id = self.id
		
		return new
	}
}

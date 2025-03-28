//
//  WorkoutModel.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 28.03.25.
//

import Foundation
import SwiftData

@Model
class WorkoutModel: Identifiable {
	
	var id: UUID
	var date: Date
	var name: String
	var groups: [WorkoutGroupModel] = []
	
	init(name: String, date: Date = .now) {
		self.id = UUID()
		self.name = name
		self.date = date
	}
	
	
	func addNewGroup() -> WorkoutGroupModel {
		var groupAmount: Int = groups.count
		
		let newGroup = WorkoutGroupModel(name: "Group \(groupAmount + 1)", order: groupAmount + 1)
		
		groups.append(newGroup)
		return newGroup
	}
	
	var calculatedSetsAndExercises: String {
		return "heeeeellllooooooo"
	}

	
}

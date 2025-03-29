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
	
	var calculatedSetsAndExercises: String {
		var totalExercises = 0
		var totalSets = 0
		
		for group in groups {
			for setGroup in group.setGroups {
				totalSets += setGroup.sets.count
			}
			totalExercises += group.setGroups.count
		}
		
		return "\(totalExercises) exercises, \(totalSets) sets"
	}

	
}

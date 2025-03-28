//
//  ExerciseModel.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 28.03.25.
//

import Foundation
import SwiftData

@Model
class ExerciseModel {
	var id: UUID
	var name: String
	var category: ExerciseCategory
	var bodyPart: BodyPart
	var explanation: String = ""
	
	@Relationship(deleteRule: .nullify) var setGroups: [ExerciseSetGroupModel]?
	
	init(name: String, category: ExerciseCategory, bodyPart: BodyPart) {
		self.id = UUID()
		self.name = name
		self.category = category
		self.bodyPart = bodyPart
	}
}


enum ExerciseCategory: String, CaseIterable, Codable {
	case strength, cardio, flexibility, balance
}

enum BodyPart: String, CaseIterable, Codable {
	case chest, back, legs, arms, core, fullBody
}

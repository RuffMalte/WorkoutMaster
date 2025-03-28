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
	var equipment: [ExerciseEquipment] = []
	
	@Relationship(deleteRule: .nullify) var setGroups: [ExerciseSetGroupModel]?
	
	init(name: String, category: ExerciseCategory, bodyPart: BodyPart) {
		self.id = UUID()
		self.name = name
		self.category = category
		self.bodyPart = bodyPart
	}
	
	var formatedEquipment: String {
		equipment.map(\.name).joined(separator: ", ")
	}
}


enum ExerciseCategory: String, CaseIterable, Codable {
	case strength, cardio, flexibility, balance
}

enum ExerciseEquipment: String, CaseIterable, Codable {
	case machine, bodyweight, resistanceBands, dumbbells, kettlebells, yogaMat, other
	
	
	var name: String {
		switch self {
		case .machine:
			return "Machine"
		case .bodyweight:
			return "Bodyweight"
		case .resistanceBands:
			return "Resistance Bands"
		case .dumbbells:
			return "Dumbbells"
		case .kettlebells:
			return "Kettlebells"
		case .yogaMat:
			return "Yoga-Mat"
		case .other:
			return "Other"
		}
	}
	
	var iconName: String {
		switch self {
		case .machine:
			return "gear"
		case .bodyweight:
			return "person"
		case .resistanceBands:
			return "line.diagonal"
		case .dumbbells:
			return "scalemass"
		case .kettlebells:
			return "bell"
		case .yogaMat:
			return "figure.yoga"
		case .other:
			return "ellipsis"
		}
	}
	
}

enum BodyPart: String, CaseIterable, Codable {
	case chest, back, legs, arms, core, fullBody
}

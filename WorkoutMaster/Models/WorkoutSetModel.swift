//
//  WorkoutSetModel.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 28.03.25.
//

import Foundation
import SwiftData

@Model
class WorkoutSetModel {
	var weight: Double
	var reps: Int
	var duration: TimeInterval?
	var order: Int
	
	init(weight: Double = 0, reps: Int = 0, duration: TimeInterval? = nil) {
		self.weight = weight
		self.reps = reps
		self.duration = duration
		self.order = 0
	}
}

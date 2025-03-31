//
//  CalorieCalculator.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 31.03.25.
//

import Foundation

struct CalorieCalculator {
	static func caloriesBurned(
		met: Double,
		weightKg: Double,
		durationMinutes: Double
	) -> Double {
		(met * 3.5 * weightKg * durationMinutes) / 200
	}
}

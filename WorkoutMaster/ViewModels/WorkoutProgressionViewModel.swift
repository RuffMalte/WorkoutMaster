//
//  WorkoutProgressionViewModel.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 31.03.25.
//

import Foundation

class WorkoutProgressionViewModel: ObservableObject {
	private let workout: WorkoutModel
	@Published var currentGroupIndex = 0
	@Published var currentExerciseIndex = 0
	@Published var currentSetIndex = 0
	@Published var completedReps = 0
	@Published var workoutCompleted = false
	@Published var startDate: Date = Date()
	@Published var totalCalories: Double = 0
	private var updateTimer: Timer?
	@Published var lastUpdateTime = Date()
	@Published var isWorkoutCompleted = false
	
	init(workout: WorkoutModel) {
		self.workout = workout
		startCalorieTimer()
	}
	
	var currentExerciseName: String {
		guard currentGroupIndex < workout.groups.count,
			  currentExerciseIndex < workout.groups[currentGroupIndex].setGroups.count else {
			return "Unknown Exercise"
		}
		return workout.groups[currentGroupIndex].setGroups[currentExerciseIndex].exercise.name
	}
	
	var currentSet: WorkoutSetModel {
		workout.groups[currentGroupIndex].setGroups[currentExerciseIndex].sets[currentSetIndex]
	}
	
	var nextExercise: ExerciseModel? {
		if currentExerciseIndex + 1 < workout.groups[currentGroupIndex].setGroups.count {
			return workout.groups[currentGroupIndex].setGroups[currentExerciseIndex + 1].exercise
		}
		
		if currentGroupIndex + 1 < workout.groups.count,
		   !workout.groups[currentGroupIndex + 1].setGroups.isEmpty {
			return workout.groups[currentGroupIndex + 1].setGroups[0].exercise
		}
		
		return nil
	}
	
	var hasMoreExercises: Bool {
		if currentSetIndex + 1 < currentExercise.sets.count { return true }
		if currentExerciseIndex + 1 < currentGroup.setGroups.count { return true }
		if currentGroupIndex + 1 < workout.groups.count { return true }
		return false
	}
	
	var currentGroup: WorkoutGroupModel {
		workout.groups[currentGroupIndex]
	}
	
	var currentExercise: ExerciseSetGroupModel {
		currentGroup.setGroups[currentExerciseIndex]
	}
	
	func initializeWorkout() {
		if !workout.groups.isEmpty,
		   !workout.groups[0].setGroups.isEmpty,
		   !workout.groups[0].setGroups[0].sets.isEmpty {
			completedReps = 0
		}
	}
	
	func calculateProgress() -> Double {
		let totalSets = workout.groups.reduce(0) { $0 + $1.setGroups.reduce(0) { $0 + $1.sets.count } }
		var completedSets = 0
		
		for i in 0..<currentGroupIndex {
			completedSets += workout.groups[i].setGroups.reduce(0) { $0 + $1.sets.count }
		}
		
		for i in 0..<currentExerciseIndex {
			completedSets += workout.groups[currentGroupIndex].setGroups[i].sets.count
		}
		
		completedSets += currentSetIndex
		
		if completedReps == currentSet.reps {
			completedSets += 1
		}
		
		return totalSets > 0 ? Double(completedSets) / Double(totalSets) : 0
	}
	
	func incrementReps() {
		completedReps = min(completedReps + 1, currentSet.reps)
	}
	
	func decrementReps() {
		completedReps = max(0, completedReps - 1)
	}
	
	func completeQuarterReps() {
		let quarterReps = max(1, Int(ceil(Double(currentSet.reps) / 4.0)))
		completedReps = min(currentSet.reps, completedReps + quarterReps)
	}
	
	func completeHalfReps() {
		let halfReps = max(1, Int(ceil(Double(currentSet.reps) / 2.0)))
		completedReps = min(currentSet.reps, completedReps + halfReps)
	}
	
	func completeAllReps() {
		completedReps = currentSet.reps
	}
	
	func advanceWorkout() -> Bool {
		guard completedReps == currentSet.reps else { return false }
		updateCalories()

		
		if currentSetIndex + 1 < currentExercise.sets.count {
			currentSetIndex += 1
			completedReps = 0
			return false
		}
		
		if currentExerciseIndex + 1 < currentGroup.setGroups.count {
			currentExerciseIndex += 1
			currentSetIndex = 0
			completedReps = 0
			return false
		}
		
		if currentGroupIndex + 1 < workout.groups.count {
			currentGroupIndex += 1
			currentExerciseIndex = 0
			currentSetIndex = 0
			completedReps = 0
			return false
		}
		
		workoutCompleted = true
		return true
	}
	
	private func startCalorieTimer() {
		updateTimer = Timer.scheduledTimer(
			withTimeInterval: 5,  // Update every 5 seconds
			repeats: true
		) { [weak self] _ in
			self?.updateCalories()
		}
	}
	
	func updateCalories() {
		let duration = Date().timeIntervalSince(startDate) / 60
		let currentMET = currentExercise.exercise.metValue
				
		totalCalories = CalorieCalculator.caloriesBurned(
			met: currentMET,
			weightKg: HealthKitManager.shared.userWeight,
			durationMinutes: duration
		)
	}
	
	var totalSetsCompleted: Int {
		workout.groups.flatMap { $0.setGroups }.reduce(0) { $0 + $1.sets.count }
	}
	
	var totalRepsCompleted: Int {
		workout.groups.flatMap { $0.setGroups }.flatMap { $0.sets }.reduce(0) { $0 + $1.reps }
	}
}

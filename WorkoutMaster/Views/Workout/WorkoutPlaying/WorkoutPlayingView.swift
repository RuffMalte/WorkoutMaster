//
//  WorkoutPlayingView.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 30.03.25.
//

import SwiftUI

struct WorkoutPlayingView: View {
	@Bindable var workout: WorkoutModel
	@Environment(\.dismiss) private var dismiss
	
	// Current position in workout
	@State private var currentGroupIndex: Int = 0
	@State private var currentExerciseIndex: Int = 0
	@State private var currentSetIndex: Int = 0
	
	// Remaining reps tracking
	@State private var completedReps: Int = 0

	// Timer state
	@State private var timeElapsed: TimeInterval = 0
	@State private var timer: Timer? = nil
	@State private var isRunning: Bool = true
	@State private var startTime: Date = Date()
	
	var body: some View {
		VStack(spacing: 10) {
			HStack(alignment: .center) {
				WorkoutItemHeaderView(workout: workout)
				
				Spacer()
				
				Button {
					stopTimer()
					dismiss()
				} label: {
					Image(systemName: "x.circle.fill")
						.foregroundStyle(.secondary)
						.font(.title3)
				}
				.buttonStyle(.plain)
			}
			
			// Timer and heart rate
			HStack {
				Text(formatTimeInterval(timeElapsed))
				
				Spacer()
				
				Label("120", systemImage: "heart.fill")
					.foregroundStyle(.red)
					.symbolEffect(.bounce.up.byLayer, options: .repeat(.periodic(delay: 0.3)))
			}
			.font(.system(.subheadline, design: .monospaced, weight: .medium))
			
			ProgressView(value: calculateProgress())
			
			CurrentExerciseView(exerciseName: currentExerciseName)
			
			RepCounterView(
				currentSetIndex: currentSetIndex,
				totalSets: workout.groups[currentGroupIndex].setGroups[currentExerciseIndex].sets.count,
				completedReps: completedReps,
				totalReps: currentSet.reps,
				onIncrement: incrementReps,
				onDecrement: decrementReps
			)

			
			Divider()
				.padding(.vertical, PaddingConstants.medium)
			
			VStack(spacing: 10) {
				RepActionButtonsView(
					onQuarterReps: completeQuarterReps,
					onHalfReps: completeHalfReps,
					onAllReps: completeAllReps
				)
				
				Button {
					// Complete current set if not finished
					if completedReps < currentSet.reps {
						completeAllReps()
					}
					
					// Attempt to advance workout
					let workoutCompleted = advanceWorkout()
					
					// Dismiss if workout is complete
					if workoutCompleted {
						dismiss()
					}
				} label: {
					if hasMoreExercises {
						Label("Next", systemImage: "arrow.right.circle.fill")
							.centeredHStack()
					} else {
						Label("Finish", systemImage: "checkmark.circle.fill")
							.centeredHStack()
					}
				}
				.buttonStyle(.plain)
				.coloredPillBackground()
			}
			.font(.system(.headline, design: .rounded, weight: .medium))
			.foregroundStyle(.white)
			.buttonStyle(.plain)
			
			Divider()
				.padding(.vertical, PaddingConstants.medium)
			
			// Next exercise info
			NextExerciseInfoView(
				nextExercise: nextExercise,
				caloriesBurned: 12 // Placeholder value
			)
			
			// Stop/Resume button
			Button {
				toggleTimer()
			} label: {
				Label(isRunning ? "Stop" : "Resume", systemImage: isRunning ? "pause" : "play")
					.foregroundStyle(.white)
			}
			.coloredPillBackground(.red)
			
			Spacer()
		}
		.padding()
		.onAppear {
			initializeWorkout()
			startTimer()
		}
		.onDisappear {
			stopTimer()
		}
	}
	
	private var currentExerciseName: String {
		if currentGroupIndex < workout.groups.count,
		   currentExerciseIndex < workout.groups[currentGroupIndex].setGroups.count {
			return workout.groups[currentGroupIndex].setGroups[currentExerciseIndex].exercise.name
		}
		return "Unknown Exercise"
	}
	
	private var currentSet: WorkoutSetModel {
		workout.groups[currentGroupIndex].setGroups[currentExerciseIndex].sets[currentSetIndex]
	}
	
	private var nextExercise: ExerciseModel? {
		// Check if there's another exercise in the current group
		if currentExerciseIndex + 1 < workout.groups[currentGroupIndex].setGroups.count {
			return workout.groups[currentGroupIndex].setGroups[currentExerciseIndex + 1].exercise
		}
		
		// Check if there's another group with exercises
		if currentGroupIndex + 1 < workout.groups.count,
		   !workout.groups[currentGroupIndex + 1].setGroups.isEmpty {
			return workout.groups[currentGroupIndex + 1].setGroups[0].exercise
		}
		
		// No more exercises
		return nil
	}
	
	private var hasMoreExercises: Bool {
		// Check if there are more sets in current exercise
		if currentSetIndex + 1 < workout.groups[currentGroupIndex].setGroups[currentExerciseIndex].sets.count {
			return true
		}
		
		// Check if there are more exercises in current group
		if currentExerciseIndex + 1 < workout.groups[currentGroupIndex].setGroups.count {
			return true
		}
		
		// Check if there are more groups with exercises
		if currentGroupIndex + 1 < workout.groups.count {
			return true
		}
		
		return false
	}
	
	// MARK: - Methods
	
	private func initializeWorkout() {
		if !workout.groups.isEmpty,
		   !workout.groups[0].setGroups.isEmpty,
		   !workout.groups[0].setGroups[0].sets.isEmpty {
			completedReps = 0 // Start with no completed reps
		}
	}
	
	private func calculateProgress() -> Double {
		let totalSets = workout.groups.reduce(0) {
			$0 + $1.setGroups.reduce(0) { $0 + $1.sets.count }
		}
		
		var completedSets = 0
		
		// 1. Count fully completed groups
		for i in 0..<currentGroupIndex {
			completedSets += workout.groups[i].setGroups.reduce(0) {
				$0 + $1.sets.count
			}
		}
		
		// 2. Count fully completed exercises in current group
		for i in 0..<currentExerciseIndex {
			completedSets += workout.groups[currentGroupIndex].setGroups[i].sets.count
		}
		
		// 3. Count fully completed sets in current exercise
		completedSets += currentSetIndex  // Already completed sets
		
		// 4. Add current set ONLY if it's fully completed
		if completedReps == currentSet.reps {
			completedSets += 1
		}
		
		return totalSets > 0 ? Double(completedSets) / Double(totalSets) : 0
	}

	
	private func incrementReps() {
		completedReps = min(completedReps + 1, currentSet.reps)
	}
	
	private func decrementReps() {
		completedReps = max(0, completedReps - 1)
	}
	
	private func completeQuarterReps() {
		let quarterReps = max(1, Int(ceil(Double(currentSet.reps) / 4.0)))
		completedReps = min(currentSet.reps, completedReps + quarterReps)
	}
	
	private func completeHalfReps() {
		let halfReps = max(1, Int(ceil(Double(currentSet.reps) / 2.0)))
		completedReps = min(currentSet.reps, completedReps + halfReps)
	}
	
	private func completeAllReps() {
		completedReps = currentSet.reps
	}
	
	
	private func startTimer() {
		stopTimer() // Ensure no multiple timers
		
		startTime = Date()
		isRunning = true
		
		timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
			self.timeElapsed += 1.0
		}
	}
	
	private func stopTimer() {
		timer?.invalidate()
		timer = nil
		isRunning = false
	}
	
	private func toggleTimer() {
		if isRunning {
			stopTimer()
		} else {
			startTimer()
		}
	}
	
	private func formatTimeInterval(_ interval: TimeInterval) -> String {
		let minutes = Int(interval) / 60
		let seconds = Int(interval) % 60
		return String(format: "%02d:%02d", minutes, seconds)
	}

	
	private func advanceWorkout() -> Bool {
		guard completedReps == currentSet.reps else { return false }
		
		// Try to advance to next set
		if currentSetIndex + 1 < currentExercise.sets.count {
			currentSetIndex += 1
			completedReps = 0
			return false
		}
		
		// Try to advance to next exercise
		if currentExerciseIndex + 1 < currentGroup.setGroups.count {
			currentExerciseIndex += 1
			currentSetIndex = 0
			completedReps = 0
			return false
		}
		
		// Try to advance to next group
		if currentGroupIndex + 1 < workout.groups.count {
			currentGroupIndex += 1
			currentExerciseIndex = 0
			currentSetIndex = 0
			completedReps = 0
			return false
		}
		
		// Workout complete
		return true
	}
	
	private var currentGroup: WorkoutGroupModel {
		workout.groups[currentGroupIndex]
	}
	
	private var currentExercise: ExerciseSetGroupModel {
		currentGroup.setGroups[currentExerciseIndex]
	}

}


#Preview {
	WorkoutPlayingView(workout: WorkoutModel.preview)
}

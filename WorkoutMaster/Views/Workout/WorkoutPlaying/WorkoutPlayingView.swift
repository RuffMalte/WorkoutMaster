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
	@StateObject private var timerVM = TimerViewModel()
	@StateObject private var progressionVM: WorkoutProgressionViewModel

	@EnvironmentObject private var healthKitManager: HealthKitManager

	init(workout: WorkoutModel) {
		self.workout = workout
		self._progressionVM = StateObject(wrappedValue: WorkoutProgressionViewModel(workout: workout))
	}
	
	var body: some View {
		VStack(spacing: 10) {
			HStack(alignment: .center) {
				WorkoutItemHeaderView(workout: workout)
				
				Spacer()
				
				Button {
					timerVM.stopTimer()
					dismiss()
				} label: {
					Image(systemName: "x.circle.fill")
						.foregroundStyle(.secondary)
						.font(.title3)
				}
				.buttonStyle(.plain)
			}
			
			HStack {
				Text(timerVM.formattedTime())
				
				Spacer()
				
				if healthKitManager.isAvailable {
					Label(
						"\(Int(healthKitManager.latestHeartRate))",
						systemImage: "heart.fill"
					)
					.foregroundStyle(.red)
					.symbolEffect(.bounce.up.byLayer, options: .repeat(.periodic(delay: 0.3)))
				} else {
					Label("N/A", systemImage: "heart.slash")
						.foregroundStyle(.gray)
				}
			}
			.font(.system(.subheadline, design: .monospaced, weight: .medium))
			
			ProgressView(value: progressionVM.calculateProgress())
			
			CurrentExerciseView(
				exercise: progressionVM.currentExercise.exercise,
				completedReps: progressionVM.completedReps,
				totalReps: progressionVM.currentSet.reps
			)
			
			RepCounterView(
				currentSetIndex: progressionVM.currentSetIndex,
				totalSets: progressionVM.currentExercise.sets.count,
				completedReps: progressionVM.completedReps,
				totalReps: progressionVM.currentSet.reps,
				onIncrement: progressionVM.incrementReps,
				onDecrement: progressionVM.decrementReps
			)
			
			Divider()
				.padding(.vertical, PaddingConstants.medium)
			
			VStack(spacing: 10) {
				RepActionButtonsView(
					onQuarterReps: progressionVM.completeQuarterReps,
					onHalfReps: progressionVM.completeHalfReps,
					onAllReps: progressionVM.completeAllReps
				)
				
				HStack {
					Button {
						withAnimation {
							timerVM.toggleTimer()
						}
					} label: {
						Label(timerVM.isRunning ? "Stop" : "Resume", systemImage: timerVM.isRunning ? "pause" : "play")
							.foregroundStyle(.white)
					}
					.coloredPillBackground(.red)
					
					Button {
						withAnimation {
							
							
							if progressionVM.completedReps < progressionVM.currentSet.reps {
								progressionVM.completeAllReps()
							}
							
							if progressionVM.advanceWorkout() {
								let startDate = progressionVM.startDate
								let endDate = Date()
								let caloriesBurned = progressionVM.totalCalories
								
								healthKitManager.saveWorkout(
									activityType: .functionalStrengthTraining,
									start: startDate,
									end: endDate,
									caloriesBurned: caloriesBurned
								) { success, error in
									DispatchQueue.main.async {
										if success {
											print("Workout saved to HealthKit!")
											//TODO: Post workout report
											dismiss()
										} else {
											print("Error saving workout:", error?.localizedDescription ?? "Unknown error")
										}
									}
								}
							}
						}
					} label: {
						if progressionVM.hasMoreExercises {
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
			}
			.font(.system(.headline, design: .rounded, weight: .medium))
			.foregroundStyle(.white)
			.buttonStyle(.plain)
			
			Divider()
				.padding(.vertical, PaddingConstants.medium)
			
			NextExerciseInfoView(
				nextExercise: progressionVM.nextExercise,
				caloriesBurned: Int(progressionVM.totalCalories)
			)
			
			
			Spacer()
		}
		.padding()
		.onAppear {
			progressionVM.initializeWorkout()
			timerVM.startTimer()
			healthKitManager.setupHealthKit()
			healthKitManager.startMonitoringHeartRate()
		}
		.onDisappear {
			timerVM.stopTimer()
			healthKitManager.stopMonitoringHeartRate()

		}
	}
}

#Preview {
	WorkoutPlayingView(workout: WorkoutModel.preview)
		.withEnvironmentObjects()
}

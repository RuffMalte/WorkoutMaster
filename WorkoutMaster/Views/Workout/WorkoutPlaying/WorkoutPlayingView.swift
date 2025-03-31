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

	@State private var showWorkoutReport = false
	
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
								self.showWorkoutReport = true
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
		.sheet(isPresented: $showWorkoutReport) {
			WorkoutReportView(
				workout: workout,
				totalDuration: timerVM.timeElapsed,
				totalSets: progressionVM.totalSetsCompleted,
				totalReps: progressionVM.totalRepsCompleted,
				caloriesBurned: progressionVM.totalCalories,
				onSave: {
					let startDate = progressionVM.startDate
					let endDate = Date()
					
					healthKitManager.saveWorkout(
						activityType: .functionalStrengthTraining,
						start: startDate,
						end: endDate,
						caloriesBurned: progressionVM.totalCalories
					) { success, error in
						DispatchQueue.main.async {
							if success {
								print("Workout saved to HealthKit!")
								dismiss()
							} else {
								print("Error saving workout:", error?.localizedDescription ?? "Unknown error")
							}
						}
					}
				}
			)
			.environmentObject(healthKitManager)
			.presentationDetents([.medium, .large])
		}
	}
}

#Preview {
	WorkoutPlayingView(workout: WorkoutModel.preview)
		.withEnvironmentObjects()
}

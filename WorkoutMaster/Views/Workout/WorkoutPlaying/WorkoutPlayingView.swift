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
				
				Label("120", systemImage: "heart.fill")
					.foregroundStyle(.red)
					.symbolEffect(.bounce.up.byLayer, options: .repeat(.periodic(delay: 0.3)))
			}
			.font(.system(.subheadline, design: .monospaced, weight: .medium))
			
			ProgressView(value: progressionVM.calculateProgress())
			
			CurrentExerciseView(exerciseName: progressionVM.currentExerciseName)
			
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
				
				Button {
					if progressionVM.completedReps < progressionVM.currentSet.reps {
						progressionVM.completeAllReps()
					}
					
					if progressionVM.advanceWorkout() {
						dismiss()
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
			.font(.system(.headline, design: .rounded, weight: .medium))
			.foregroundStyle(.white)
			.buttonStyle(.plain)
			
			Divider()
				.padding(.vertical, PaddingConstants.medium)
			
			NextExerciseInfoView(
				nextExercise: progressionVM.nextExercise,
				caloriesBurned: 12
			)
			
			Button {
				timerVM.toggleTimer()
			} label: {
				Label(timerVM.isRunning ? "Stop" : "Resume", systemImage: timerVM.isRunning ? "pause" : "play")
					.foregroundStyle(.white)
			}
			.coloredPillBackground(.red)
			
			Spacer()
		}
		.padding()
		.onAppear {
			progressionVM.initializeWorkout()
			timerVM.startTimer()
		}
		.onDisappear {
			timerVM.stopTimer()
		}
	}
}

#Preview {
	WorkoutPlayingView(workout: WorkoutModel.preview)
}

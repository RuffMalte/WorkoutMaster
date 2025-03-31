//
//  WorkoutReportView.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 31.03.25.
//

import SwiftUI

struct WorkoutReportView: View {
	@Environment(\.dismiss) var dismiss
	let workout: WorkoutModel
	let totalDuration: TimeInterval
	let totalSets: Int
	let totalReps: Int
	let caloriesBurned: Double
	let onSave: () -> Void
	
	var body: some View {
		VStack(spacing: 20) {
			HStack {
				Text("Workout Complete")
					.font(.title2.weight(.bold))
				
				Spacer()
				
				Button {
					dismiss()
				} label: {
					Image(systemName: "xmark.circle.fill")
						.foregroundStyle(.secondary)
						.font(.title2)
				}
				.buttonStyle(.plain)
			}
			
			VStack(spacing: 15) {
				StatBadge(
					title: "Duration",
					value: formattedTime,
					icon: "clock.fill",
					color: .blue
				)
				
				StatBadge(
					title: "Sets Completed",
					value: "\(totalSets)",
					icon: "repeat.circle.fill",
					color: .purple
				)
				
				StatBadge(
					title: "Total Reps",
					value: "\(totalReps)",
					icon: "number.circle.fill",
					color: .orange
				)
				
				StatBadge(
					title: "Calories Burned",
					value: String(format: "%.0f", caloriesBurned),
					icon: "flame.fill",
					color: .red
				)
			}
			
			Button {
				onSave()
				dismiss()
			} label: {
				Label("Save Workout", systemImage: "checkmark.circle.fill")
					.centeredHStack()
					.coloredPillBackground(.green)
			}
			.buttonStyle(.plain)
			.foregroundStyle(.white)
			.fontWeight(.bold)
			
			Spacer()
		}
		.padding()
		.presentationDetents([.medium])
		.presentationCornerRadius(20)
	}
	
	private var formattedTime: String {
		let minutes = Int(totalDuration) / 60
		let seconds = Int(totalDuration) % 60
		return String(format: "%02d:%02d", minutes, seconds)
	}
}

struct StatBadge: View {
	let title: String
	let value: String
	let icon: String
	let color: Color
	
	var body: some View {
		HStack {
			Label(title, systemImage: icon)
				.foregroundStyle(color)
				.font(.system(.headline, design: .rounded, weight: .medium))
			
			Spacer()
			
			Text(value)
				.font(.system(.title3, design: .monospaced, weight: .bold))
		}
		.padding()
		.background(color.opacity(0.1))
		.cornerRadius(12)
	}
}


#Preview {
	WorkoutReportView(
		workout: WorkoutModel.preview,
		totalDuration: TimeInterval(),
		totalSets: 5,
		totalReps: 89,
		caloriesBurned: 141.2, onSave: {
			print("save")
		})
}

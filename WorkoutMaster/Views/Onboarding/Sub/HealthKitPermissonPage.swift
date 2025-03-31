//
//  HealthKitPermissonPage.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 31.03.25.
//

import SwiftUI

struct HealthKitPermissonPage: View {
	@EnvironmentObject private var healthKitManager: HealthKitManager

    var body: some View {
		VStack(spacing: 20) {
			Image(systemName: "heart.text.square.fill")
				.font(.system(size: 80))
				.foregroundStyle(.red)
			
			VStack(spacing: 10) {
				Text("Health Integration")
					.font(.title2.bold())
				
				Text("Connect with Apple Health to track heart rate, save workouts, and calculate calories burned.")
					.multilineTextAlignment(.center)
					.foregroundStyle(.secondary)
			}
			
			VStack(spacing: 15) {
				Button {
					healthKitManager.setupHealthKit()
				} label: {
					Label(
						healthKitManager.isAvailable ? "HealthKit Connected" : "Connect HealthKit",
						systemImage: healthKitManager.isAvailable ? "checkmark.circle.fill" : "heart.fill"
					)
					.foregroundStyle(.white)
					.fontWeight(.bold)
					.centeredHStack()
					.coloredPillBackground(healthKitManager.isAvailable ? .green : .blue)
				}
				.disabled(healthKitManager.isAvailable)
				
				if !healthKitManager.isAvailable {
					Text("HealthKit access is optional but recommended for full functionality")
						.font(.caption)
						.foregroundStyle(.secondary)
				}
			}
			
			Spacer()
		}
		.padding(.top, PaddingConstants.large)
	}
}

#Preview {
    HealthKitPermissonPage()
		.withEnvironmentObjects()
}

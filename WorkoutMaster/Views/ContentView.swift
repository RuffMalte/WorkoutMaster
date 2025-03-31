//
//  ContentView.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 28.03.25.
//

import SwiftUI

struct ContentView: View {
	@EnvironmentObject private var healthKit: HealthKitManager

	
    var body: some View {
		TabView {
			Tab("Workouts", systemImage: "figure.run") {
				WorkoutView()
			}
			
			Tab("History", systemImage: "clock.arrow.trianglehead.counterclockwise.rotate.90") {
				VStack {
					if healthKit.latestHeartRate == 9999 {
						Text("No heart rate data")
					} else {
						Text("Current HR: \(Int(healthKit.latestHeartRate))")
					}
				}
			}
			
			Tab("Biology", systemImage: "heart.fill") {
				Text("helloππ")
			}
		}
		.tabViewStyle(.sidebarAdaptable)
		.onAppear { healthKit.setupHealthKit() } // Only call setup once
		.onDisappear { healthKit.stopMonitoringHeartRate() }
    }
}

#Preview {
    ContentView()
		.modelContainer(previewContainer)
}

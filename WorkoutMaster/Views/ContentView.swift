//
//  ContentView.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 28.03.25.
//

import SwiftUI

struct ContentView: View {
	
    var body: some View {
		TabView {
			Tab("Workouts", systemImage: "figure.run") {
				WorkoutView()
			}
		}
		.tabViewStyle(.sidebarAdaptable)
    }
}

#Preview {
    ContentView()
		.modelContainer(previewContainer)
}

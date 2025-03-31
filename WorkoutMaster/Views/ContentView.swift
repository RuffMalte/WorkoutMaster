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
			
			Tab("History", systemImage: "clock.arrow.trianglehead.counterclockwise.rotate.90") {
				Text("hawd")
			}
			
			Tab("Biology", systemImage: "heart.fill") {
				Text("helloππ")
			}
		}
		.tabViewStyle(.sidebarAdaptable)
    }
}

#Preview {
    ContentView()
		.modelContainer(previewContainer)
}

//
//  OnboardingPage1View.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 31.03.25.
//

import SwiftUI

struct OnboardingPage1View: View {
    var body: some View {
		VStack(spacing: 20) {
			Image(systemName: "figure.run.circle.fill")
				.font(.system(size: 80))
				.foregroundStyle(.blue)
			
			VStack(spacing: 10) {
				Text("Welcome to WorkoutMaster")
					.font(.title2.bold())
				
				Text("Track your workouts and achieve all your fitness goals.")
					.multilineTextAlignment(.center)
					.foregroundStyle(.secondary)
			}
			
			Spacer()
		}
		.padding(.top, PaddingConstants.large)
    }
}

#Preview {
    OnboardingPage1View()
}

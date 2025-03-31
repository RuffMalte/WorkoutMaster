//
//  OnboardingView.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 31.03.25.
//

import SwiftUI

struct OnboardingView: View {
	@Environment(\.dismiss) private var dismiss
	@State private var currentPage = 0
	@AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
	
	var body: some View {
		VStack {
			TabView(selection: $currentPage) {
				OnboardingPage1View()
					.tag(0)
				
				HealthKitPermissonPage()
					.tag(1)
				
				SetupCompletePageView()
					.tag(2)
			}
			.tabViewStyle(.page(indexDisplayMode: .always))
			.indexViewStyle(.page(backgroundDisplayMode: .always))
			
			controlsSection
		}
		.padding()
		.background(Color(.systemGroupedBackground))
	}
	
	private var controlsSection: some View {
		HStack {
			if currentPage > 0 {
				Button("Back") {
					withAnimation {
						currentPage -= 1
					}
				}
				.fontWeight(.bold)
				.foregroundStyle(.white)
				.buttonStyle(.plain)
				.coloredPillBackground(.secondary)
			}
			
			Spacer()
			
			Button {
				withAnimation {
					if currentPage == 2 {
						completeOnboarding()
					} else {
						currentPage += 1
					}
				}
			} label: {
				Text(currentPage == 2 ? "Get Started" : "Continue")
					.centeredHStack()
					.foregroundStyle(.white)
					.fontWeight(.bold)
			}
			.buttonStyle(.plain)
			.coloredPillBackground(.accentColor)
			
		}
		.padding(.horizontal)
	}
	
	private func completeOnboarding() {
		hasCompletedOnboarding = true
		dismiss()
	}
}

#Preview {
    OnboardingView()
		.withEnvironmentObjects()
}

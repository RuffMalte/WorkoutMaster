//
//  WorkoutMasterApp.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 28.03.25.
//

import SwiftUI
import SwiftData

@main
struct WorkoutMasterApp: App {
	
	
	let container: ModelContainer
	@AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
	@State private var showOnboarding = false
	
	init() {
		let schema = Schema([
			ExerciseModel.self,
			ExerciseSetGroupModel.self,
			WorkoutGroupModel.self,
			WorkoutModel.self,
			WorkoutSetModel.self
		])
		let config = ModelConfiguration("iCloud.com.MalteRuff.WorkoutMaster", schema: schema)
		do {
			container = try ModelContainer(for: schema, configurations: config)
		} catch {
			fatalError("Could not configure the container")
		}
	}

	
	
    var body: some Scene {
        WindowGroup {
            ContentView()
				.environmentObject(HealthKitManager.shared)
				.onAppear {
					if !hasCompletedOnboarding {
						showOnboarding = true
					}
				}
				.sheet(isPresented: $showOnboarding) {
					OnboardingView()
						.environmentObject(HealthKitManager.shared)
						.modelContainer(container)
				}
				.onChange(of: hasCompletedOnboarding) { _, newValue in
					if newValue {
						preloadDefaultExercises()
					}
				}
        }
		.modelContainer(container)
    }
	
	private func preloadDefaultExercises() {
		let context = ModelContext(container)
		let exerciseCount = (try? context.fetchCount(FetchDescriptor<ExerciseModel>())) ?? 0
		
		if exerciseCount == 0 {
			DefaultExerciseLoader.loadDefaultExercises(context: context)
			try? context.save()
		}
	}
}

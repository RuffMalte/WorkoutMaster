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
		print(URL.applicationSupportDirectory.path(percentEncoded: false))
	}

	
	
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
		.modelContainer(container)
    }
}

//
//  PreviewContainer.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 28.03.25.
//

import Foundation

import SwiftData
@MainActor
let previewContainer: ModelContainer = {
	do {
		let container = try ModelContainer(
			for:
				ExerciseModel.self,
			configurations: ModelConfiguration(isStoredInMemoryOnly: true)
		)
		let context = container.mainContext
		
		
		// Add Sample data
		ExerciseModel.previewItems.forEach { context.insert($0) }
		
		return container
	} catch {
		fatalError("Failed to create preview container: \(error.localizedDescription)")
	}
}()

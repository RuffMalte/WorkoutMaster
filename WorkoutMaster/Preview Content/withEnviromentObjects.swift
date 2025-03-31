//
//  withEnviromentObjects.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 31.03.25.
//

import SwiftUI

struct withEnviromentObjects: ViewModifier {
	
	
	func body(content: Content) -> some View {
		content
			.environmentObject(HealthKitManager.shared)
	}
	
}

extension View {
	func withEnvironmentObjects() -> some View {
		
		return self.modifier(withEnviromentObjects())
	}
}

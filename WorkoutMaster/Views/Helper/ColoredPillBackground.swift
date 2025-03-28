//
//  ColoredPillBackground.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 28.03.25.
//

import SwiftUI

struct ColoredPillBackground: ViewModifier {
	let color: Color
	
	func body(content: Content) -> some View {
		content
			.padding()
			.background {
				RoundedRectangle(cornerRadius: 40)
					.foregroundStyle(color)
			}
	}
}


struct BarColoredPillBackground: ViewModifier {
	func body(content: Content) -> some View {
		content
			.padding()
			.background {
				RoundedRectangle(cornerRadius: 40)
					.foregroundStyle(.bar)
			}
	}
}


extension View {
	func coloredPillBackground(_ color: Color = .green) -> some View {
		self.modifier(ColoredPillBackground(color: color))
	}
	
	func barColoredPillBackground() -> some View {
		self.modifier(BarColoredPillBackground())
	}
	
}

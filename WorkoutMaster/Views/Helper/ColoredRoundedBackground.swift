//
//  ColoredRoundedBackground.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 28.03.25.
//

import SwiftUI

struct ColoredRoundedBackground: ViewModifier {
	let color: Color
	
	func body(content: Content) -> some View {
		content
			.padding()
			.background {
				RoundedRectangle(cornerRadius: 10)
					.foregroundStyle(color)
			}
	}
}

struct BarColoredRoundedBackground: ViewModifier {
	func body(content: Content) -> some View {
		content
			.padding()
			.background {
				RoundedRectangle(cornerRadius: 10)
					.foregroundStyle(.bar)
			}
	}
}


extension View {
	func coloredRoundedBackground(_ color: Color = .green) -> some View {
		self.modifier(ColoredRoundedBackground(color: color))
	}
	
	func barColoredRoundedBackground() -> some View {
		self.modifier(BarColoredRoundedBackground())
	}
}

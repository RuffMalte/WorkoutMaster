//
//  ColoredPillBackground.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 28.03.25.
//

import SwiftUI

struct ColoredPillBackground: ViewModifier {
	let color: Color
	let padding: CGFloat
	let radius: CGFloat
	
	@Environment(\.isEnabled) private var isEnabled // Observe whether the view is enabled
	
	func body(content: Content) -> some View {
		content
			.padding(padding)
			.background {
				RoundedRectangle(cornerRadius: radius)
					.foregroundStyle(isEnabled ? color : Color.gray.opacity(0.5)) // Use gray when disabled
			}
	}
}

struct BarColoredPillBackground: ViewModifier {
	let padding: CGFloat
	let radius: CGFloat
	
	func body(content: Content) -> some View {
		content
			.padding(padding)
			.background {
				RoundedRectangle(cornerRadius: radius)
					.foregroundStyle(.bar)
			}
	}
}


extension View {
	func coloredPillBackground(
		_ color: Color = .green,
		padding: CGFloat = PaddingConstants.medium,
		radius: CGFloat = RadiusConstants.extraLarge
	) -> some View {
		self.modifier(ColoredPillBackground(color: color, padding: padding, radius: radius))
	}
	
	func barColoredPillBackground(
		padding: CGFloat = PaddingConstants.medium,
		radius: CGFloat = RadiusConstants.extraLarge
	) -> some View {
		self.modifier(BarColoredPillBackground(padding: padding, radius: radius))
	}
	
	
}

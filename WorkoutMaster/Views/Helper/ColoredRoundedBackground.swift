//
//  ColoredRoundedBackground.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 28.03.25.
//

import SwiftUI

struct ColoredRoundedBackground: ViewModifier {
	let color: Color
	let padding: CGFloat
	let radius: CGFloat
	
	func body(content: Content) -> some View {
		content
			.padding(padding)
			.background {
				RoundedRectangle(cornerRadius: radius)
					.foregroundStyle(color)
			}
	}
}

struct BarColoredRoundedBackground: ViewModifier {
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
	func coloredRoundedBackground(
		_ color: Color = .green,
		padding: CGFloat = PaddingConstants.medium,
		radius: CGFloat = RadiusConstants.medium
	) -> some View {
		self.modifier(ColoredRoundedBackground(color: color, padding: padding, radius: radius))
	}
	
	func barColoredRoundedBackground(
		padding: CGFloat = PaddingConstants.medium,
		radius: CGFloat = RadiusConstants.medium
	) -> some View {
		self.modifier(BarColoredRoundedBackground(padding: padding, radius: radius))
	}
}

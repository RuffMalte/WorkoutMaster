//
//  Color+Extension.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 28.03.25.
//

import SwiftUI

extension Color {
	static func random() -> Color {
		let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple, .pink]
		return colors.randomElement() ?? .black
	}
	
	static var adaptiveBlackWhite: Color {
		Color(UIColor { traitCollection in
			return traitCollection.userInterfaceStyle == .dark ? .black : .white
		})
	}
}


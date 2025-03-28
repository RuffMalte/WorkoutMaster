//
//  CenteredHStackModifier.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 28.03.25.
//
import SwiftUI

struct CenteredHStackModifier: ViewModifier {
    func body(content: Content) -> some View {
        HStack {
            Spacer()
            content
            Spacer()
        }
    }
}

extension View {
	func centeredHStack() -> some View {
		modifier(CenteredHStackModifier())
	}
}

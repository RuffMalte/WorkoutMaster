//
//  WorkoutItemSheetView.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 28.03.25.
//

import SwiftUI

struct WorkoutItemSheetView: View {
    var body: some View {
		VStack(alignment: .leading) {
			Text("Name")
				.font(.system(.headline, design: .rounded, weight: .bold))
			
			Text("exerciese amount" + ", " + "set Amount")
				.font(.system(.subheadline, weight: .semibold))
				.foregroundStyle(.secondary)
			
			Divider()
			
			
			Spacer()
			
			
			
			HStack {
				
				Button {
					
				} label: {
					HStack {
						Spacer()
						Label("Start Workout", systemImage: "play.fill")
							.foregroundStyle(.white)
							.font(.system(.headline, design: .rounded, weight: .bold))
						Spacer()
					}
				}
				.coloredPillBackground(.green)
				.buttonStyle(.plain)
				
				Button {
					
				} label: {
					Label("Edit", systemImage: "pencil")
						.font(.system(.headline, design: .rounded, weight: .bold))
				}
				.coloredPillBackground(.white)
				.buttonStyle(.plain)
				
			}
			
			
		}
		.padding()
		.background(.bar)
    }
}

#Preview {
    WorkoutItemSheetView()
}

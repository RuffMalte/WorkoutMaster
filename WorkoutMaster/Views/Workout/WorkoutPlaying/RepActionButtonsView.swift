//
//  RepActionButtonsView.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 30.03.25.
//

import SwiftUI

struct RepActionButtonsView: View {
	let onQuarterReps: () -> Void
	let onHalfReps: () -> Void
	let onAllReps: () -> Void
	
	var body: some View {
		LazyVGrid(columns: [
			.init(.flexible(minimum: 20)),
			.init(.flexible(minimum: 20)),
			.init(.flexible(minimum: 20))
		], alignment: .center, spacing: 10) {
			Button {
				withAnimation {
					onQuarterReps()
				}
			} label: {
				Label("1/4", systemImage: "square.split.bottomrightquarter.fill")
					.centeredHStack()
			}
			.coloredPillBackground(.blue)
			
			Button {
				withAnimation {
					onHalfReps()
				}
			} label: {
				Label("Half", systemImage: "square.split.2x1.fill")
					.centeredHStack()
			}
			.coloredPillBackground(.purple)
			
			Button {
				withAnimation {
					onAllReps()
				}
			} label: {
				Label("All", systemImage: "square.fill")
					.centeredHStack()
			}
			.coloredPillBackground(.orange)
		}
	}
}


#Preview {
	RepActionButtonsView {
		print("Quarter")
	} onHalfReps: {
		print("Half")
	} onAllReps: {
		print("All")
	}
	.buttonStyle(.plain)
	.foregroundStyle(.white)
}

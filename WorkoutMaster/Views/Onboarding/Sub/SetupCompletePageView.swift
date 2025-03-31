//
//  SetupCompletePageView.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 31.03.25.
//

import SwiftUI

struct SetupCompletePageView: View {
    var body: some View {
		VStack(spacing: 20) {
			Image(systemName: "checkmark.seal.fill")
				.font(.system(size: 80))
				.foregroundStyle(.green)
			
			VStack(spacing: 10) {
				Text("Setup Complete")
					.font(.title2.bold())
				
				Text("We've preloaded essential exercises to get you started. You can always add more later!")
					.multilineTextAlignment(.center)
					.foregroundStyle(.secondary)
			}
			
			Spacer()
		}
		.padding(.top, PaddingConstants.large)
	}
}

#Preview {
    SetupCompletePageView()
}

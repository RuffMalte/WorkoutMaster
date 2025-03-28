//
//  WorkoutItemListView.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 28.03.25.
//

import SwiftUI

struct WorkoutItemListView: View {
	
	@State private var isShowingDetails: Bool = false
	
    var body: some View {
		Button {
			isShowingDetails.toggle()
		} label: {
			HStack {
				VStack(alignment: .leading) {
					Text("Name")
						.font(.system(.headline, design: .rounded, weight: .bold))
					Text("Description")
						.font(.subheadline)
				}
				Spacer()
				
				Image(systemName: "chevron.right")
				
			}
			.padding()
			.background() {
				RoundedRectangle(cornerRadius: 10)
					.foregroundStyle(.white)
			}
		}
		.buttonStyle(.plain)
		
		.sheet(isPresented: $isShowingDetails) {
			NavigationStack {
				VStack {
					Text("hello")
				}
			}
			.presentationDetents( [.medium, .large])
		}
    }
}

#Preview {
    WorkoutItemListView()
		.background(.bar)
}

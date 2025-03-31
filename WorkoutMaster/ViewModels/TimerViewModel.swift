//
//  TimerViewModel.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 31.03.25.
//

import Foundation

class TimerViewModel: ObservableObject {
	@Published var timeElapsed: TimeInterval = 0
	@Published var isRunning = true
	private var timer: Timer?
	private var startTime = Date()
	
	func startTimer() {
		stopTimer()
		startTime = Date()
		isRunning = true
		
		timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
			guard let self = self else { return }
			self.timeElapsed += 1.0
		}
	}
	
	func stopTimer() {
		timer?.invalidate()
		timer = nil
		isRunning = false
	}
	
	func toggleTimer() {
		isRunning ? stopTimer() : startTimer()
	}
	
	func formattedTime() -> String {
		let minutes = Int(timeElapsed) / 60
		let seconds = Int(timeElapsed) % 60
		return String(format: "%02d:%02d", minutes, seconds)
	}
}

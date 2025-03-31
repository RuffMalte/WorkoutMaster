//
//  HealthKitManager.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 31.03.25.
//

import Foundation
import HealthKit

class HealthKitManager: ObservableObject {
	@Published var latestHeartRate: Double = 9999
	@Published var isAvailable: Bool = false
	@Published var error: Error? = nil
	
	private let healthStore = HKHealthStore()
	private var heartRateQuery: HKQuery?
	private var observerQuery: HKObserverQuery?

	
	static let shared = HealthKitManager()
	private init() {}
	
	func setupHealthKit() {
		guard HKHealthStore.isHealthDataAvailable() else {
			self.isAvailable = false
			self.error = HKError(.errorHealthDataUnavailable)
			return
		}
		
		let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate)!
		
		healthStore.requestAuthorization(toShare: nil, read: [heartRateType]) { success, error in
			DispatchQueue.main.async {
				if let error = error {
					self.error = error
					self.isAvailable = false
					return
				}
				
				self.isAvailable = success
				if success {
					self.startMonitoringHeartRate()
				} else {
					self.error = HKError(.errorAuthorizationDenied)
				}
			}
		}
	}
	
	func startMonitoringHeartRate() {
		guard isAvailable else { return }
		
		let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
		
		// First fetch initial value
		fetchLatestHeartRate()
		
		// Set up observer for future updates
		observerQuery = HKObserverQuery(
			sampleType: heartRateType,
			predicate: nil
		) { [weak self] _, _, error in
			if error == nil {
				self?.fetchLatestHeartRate()
			}
		}
		
		healthStore.execute(observerQuery!)
		
		// Enable background delivery (critical for updates)
		healthStore.enableBackgroundDelivery(
			for: heartRateType,
			frequency: .immediate
		) { success, error in
			if !success {
				print("Background delivery failed: \(error?.localizedDescription ?? "")")
			}
		}
	}
	
	private func fetchLatestHeartRate() {
		let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
		let sortDescriptor = NSSortDescriptor(
			key: HKSampleSortIdentifierStartDate,
			ascending: false
		)
		
		let query = HKSampleQuery(
			sampleType: heartRateType,
			predicate: nil,
			limit: 1,
			sortDescriptors: [sortDescriptor]
		) { [weak self] _, samples, error in
			self?.processSamples(samples: samples, error: error)
		}
		
		healthStore.execute(query)
	}
	
	// Process results
	private func processSamples(samples: [HKSample]?, error: Error?) {
		DispatchQueue.main.async {
			if let error = error {
				self.error = error
				return
			}
			
			guard let sample = samples?.first as? HKQuantitySample else {
				// Don't reset to 0 - keep last known value
				return
			}
			
			let heartRateUnit = HKUnit(from: "count/min")
			self.latestHeartRate = sample.quantity.doubleValue(for: heartRateUnit)
		}
	}
	
	// Stop monitoring
	func stopMonitoringHeartRate() {
		guard let query = heartRateQuery else { return }
		healthStore.stop(query)
		heartRateQuery = nil
	}
}


//
//  HealthKitManager+Extension+WorkoutSaving.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 31.03.25.
//

import Foundation
import HealthKit

extension HealthKitManager {
	func saveWorkout(
		activityType: HKWorkoutActivityType,
		start: Date,
		end: Date,
		caloriesBurned: Double,
		completion: @escaping (Bool, Error?) -> Void
	) {
		guard HKHealthStore.isHealthDataAvailable() else {
			completion(false, HKError(.errorHealthDataUnavailable))
			return
		}
		
		let configuration = HKWorkoutConfiguration()
		configuration.activityType = activityType
		
		let builder = HKWorkoutBuilder(
			healthStore: healthStore,
			configuration: configuration,
			device: .local()
		)
		
		// 1. Begin workout collection
		builder.beginCollection(withStart: start) { success, error in
			guard success else {
				completion(false, error)
				return
			}
			
			// 2. Create energy burned sample
			let energyQuantity = HKQuantity(
				unit: .kilocalorie(),
				doubleValue: caloriesBurned
			)
			
			guard let energyType = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned) else {
				completion(false, HKError(.errorHealthDataUnavailable))
				return
			}
			
			let energySample = HKQuantitySample(
				type: energyType,
				quantity: energyQuantity,
				start: start,
				end: end
			)
			
			// 3. Add samples to workout
			builder.add([energySample]) { success, error in
				guard success else {
					completion(false, error)
					return
				}
				
				// 4. End collection and finish workout
				builder.endCollection(withEnd: end) { success, error in
					guard success else {
						completion(false, error)
						return
					}
					
					builder.finishWorkout { _, error in
						DispatchQueue.main.async {
							completion(error == nil, error)
						}
					}
				}
			}
		}
	}
}

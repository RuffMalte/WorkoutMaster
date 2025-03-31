//
//  HealthKitManager+Extension+UserWeight.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 31.03.25.
//

import Foundation
import HealthKit

extension HealthKitManager {
		
	func fetchUserWeight() {
		guard let weightType = HKObjectType.quantityType(forIdentifier: .bodyMass) else { return }
				
		let query = HKSampleQuery(
			sampleType: weightType,
			predicate: nil,
			limit: 1,
			sortDescriptors: [.init(key: HKSampleSortIdentifierStartDate, ascending: false)]
		) { [weak self] _, results, _ in
			let weight = (results?.first as? HKQuantitySample)?.quantity.doubleValue(for: .gramUnit(with: .kilo)) ?? 70.0
			
			DispatchQueue.main.async {
				self?.userWeight = weight
				print(weight.description)
			}
		}
		healthStore.execute(query)
	}
}

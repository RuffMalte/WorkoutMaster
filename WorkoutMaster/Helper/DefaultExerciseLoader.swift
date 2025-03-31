//
//  DefaultExerciseLoader.swift
//  WorkoutMaster
//
//  Created by Malte Ruff on 31.03.25.
//

import SwiftUI
import SwiftData

struct DefaultExerciseLoader {
	static func loadDefaultExercises(context: ModelContext) {
		let defaultExercises = [
			// Chest Exercises
			ExerciseModel(
				name: "Push Ups",
				category: .strength,
				bodyPart: .chest,
				explanation: "Classic bodyweight exercise targeting chest, shoulders, and triceps",
				equipment: [.bodyweight]
			),
			ExerciseModel(
				name: "Bench Press",
				category: .strength,
				bodyPart: .chest,
				explanation: "Barbell compound lift for chest development",
				equipment: [.machine]
			),
			
			// Back Exercises
			ExerciseModel(
				name: "Pull-Ups",
				category: .strength,
				bodyPart: .back,
				explanation: "Bodyweight exercise for latissimus dorsi and upper back",
				equipment: [.bodyweight]
			),
			ExerciseModel(
				name: "Deadlift",
				category: .strength,
				bodyPart: .back,
				explanation: "Full-body compound lift targeting posterior chain",
				equipment: [.machine]
			),
			
			// Leg Exercises
			ExerciseModel(
				name: "Squats",
				category: .strength,
				bodyPart: .legs,
				explanation: "Fundamental lower body exercise for quadriceps and glutes",
				equipment: [.bodyweight]
			),
			ExerciseModel(
				name: "Lunges",
				category: .strength,
				bodyPart: .legs,
				explanation: "Unilateral leg exercise for balance and strength",
				equipment: [.bodyweight]
			),
			ExerciseModel(
				name: "Kettlebell Swing",
				category: .strength,
				bodyPart: .legs,
				explanation: "Hip-hinge movement for posterior chain development",
				equipment: [.kettlebells]
			),
			
			// Shoulder Exercises
			ExerciseModel(
				name: "Overhead Press",
				category: .strength,
				bodyPart: .arms,
				explanation: "Barbell shoulder press for deltoid development",
				equipment: [.machine]
			),
			ExerciseModel(
				name: "Lateral Raises",
				category: .strength,
				bodyPart: .arms,
				explanation: "Isolation exercise for medial deltoids",
				equipment: [.dumbbells]
			),
			
			// Core Exercises
			ExerciseModel(
				name: "Plank",
				category: .strength,
				bodyPart: .core,
				explanation: "Isometric core stability exercise",
				equipment: [.bodyweight]
			),
			ExerciseModel(
				name: "Russian Twists",
				category: .strength,
				bodyPart: .core,
				explanation: "Rotational core exercise with weight resistance",
				equipment: [.dumbbells]
			),
			
			// Full Body Exercises
			ExerciseModel(
				name: "Burpees",
				category: .cardio,
				bodyPart: .fullBody,
				explanation: "Full-body conditioning exercise combining squat, pushup, and jump",
				equipment: [.bodyweight]
			),
			ExerciseModel(
				name: "Mountain Climbers",
				category: .cardio,
				bodyPart: .fullBody,
				explanation: "Dynamic core exercise with cardiovascular benefits",
				equipment: [.bodyweight]
			),
			
			// Functional Exercises
			ExerciseModel(
				name: "Inchworm",
				category: .flexibility,
				bodyPart: .fullBody,
				explanation: "Combination mobility and strength exercise for hamstrings and shoulders",
				equipment: [.bodyweight]
			),
			ExerciseModel(
				name: "Bear Crawl",
				category: .balance,
				bodyPart: .fullBody,
				explanation: "Full-body movement pattern enhancing coordination and core stability",
				equipment: [.bodyweight]
			),
			
			// Resistance Band Exercises
			ExerciseModel(
				name: "Band Pull-Aparts",
				category: .strength,
				bodyPart: .back,
				explanation: "Rear deltoid and upper back activation using resistance bands",
				equipment: [.resistanceBands]
			),
			
			// Yoga/Flexibility
			ExerciseModel(
				name: "Downward Dog",
				category: .flexibility,
				bodyPart: .fullBody,
				explanation: "Yoga pose for hamstring and shoulder flexibility",
				equipment: [.yogaMat]
			),
			
			// Advanced Exercises
			ExerciseModel(
				name: "Pistol Squat",
				category: .strength,
				bodyPart: .legs,
				explanation: "Single-leg squat for advanced lower body strength",
				equipment: [.bodyweight]
			),
			ExerciseModel(
				name: "Muscle-Up",
				category: .strength,
				bodyPart: .fullBody,
				explanation: "Advanced calisthenics move combining pull-up and dip",
				equipment: [.bodyweight]
			),
			
			// Cardio Exercises
			ExerciseModel(
				name: "Jump Rope",
				category: .cardio,
				bodyPart: .fullBody,
				explanation: "High-intensity cardiovascular exercise with coordination benefits",
				equipment: [.other]
			),
			
			// Balance Exercises
			ExerciseModel(
				name: "Single-Leg Deadlift",
				category: .balance,
				bodyPart: .legs,
				explanation: "Unilateral hip hinge movement for balance and posterior chain",
				equipment: [.dumbbells]
			),
			
			// Glute Exercises
			ExerciseModel(
				name: "Hip Thrust",
				category: .strength,
				bodyPart: .legs,
				explanation: "Targeted glute activation exercise",
				equipment: [.machine]
			),
			
			// Tricep Exercises
			ExerciseModel(
				name: "Tricep Dips",
				category: .strength,
				bodyPart: .arms,
				explanation: "Bodyweight exercise for tricep development",
				equipment: [.bodyweight]
			),
			
			// Bicep Exercises
			ExerciseModel(
				name: "Hammer Curls",
				category: .strength,
				bodyPart: .arms,
				explanation: "Dumbbell curl variation targeting brachialis",
				equipment: [.dumbbells]
			),
			
			// Mobility Exercises
			ExerciseModel(
				name: "World's Greatest Stretch",
				category: .flexibility,
				bodyPart: .fullBody,
				explanation: "Dynamic mobility sequence for full-body preparation",
				equipment: [.yogaMat]
			)
		]
		
		for exercise in defaultExercises {
			context.insert(exercise)
		}
	}
}


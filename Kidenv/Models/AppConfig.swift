//
//  AppConfig.swift
//  kiddoing
//
//  Created by Donelkys Santana on 1/31/23.
//

import Foundation

enum Cartoons: String {
	case mickey = "mickey"
	case minie = "minie"
}

struct AppConfig {
	var preferredCartoon: Cartoons? {
		set (value) {
			UserDefaults().set(value, forKey: "preferred_cartoon")
		}
		get {
			return UserDefaults().value(forKey: "preferred_cartoon") as? Cartoons
		}
	}
	
	var isGuidedAccessConfigured: Bool? {
		set (value) {
			UserDefaults().set(value, forKey: "guided_access")
		}
		get {
			return UserDefaults().value(forKey: "guidedd_access") as? Bool
		}
	}
	
}
